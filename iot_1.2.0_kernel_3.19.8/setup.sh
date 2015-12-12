#!/bin/sh
########################################################################
# Configuration
########################################################################

# Linux-stable
KVER="3.19"

########################################################################
# End of configuration
########################################################################

network_proxy_error() {
cat << EOF
ERROR: wget fail to fetch $HTTP_PATH/$TEST_FILE
NOTE:
You are either not connected or behind corporate proxy
Please make sure network proxies are setup at /etc/environment or
~/.bashrc :-
http_proxy=<http proxy server path>:<port>
ftp_proxy=<ftp proxy server path>:<port>
https_proxy=<https proxy server path>:<port>
socks_server=<SOCKS server path>:<port>
EOF
}

git_proxy_warn () {
cat << EOF
CAUTION: It seems that you may not have proper git proxy setup.
         Ignore this warning if you are NOT behind network proxy or have setup it properly.

Read more about how you can setup proxy for git from "git config -help
Example of setup is in ~/.gitconfig, under [core] define "gitproxy=<path to bash script>"
Example of bash script:
=============================================
#!/bin/bash
exec socat stdio SOCKS:<proxy IP/DNS>:\$1:\$2
=============================================
EOF
}

test_git () {
	# Checking if git is installed on system
	GIT_PATH=`whereis git | cut -d' ' -f2`
	if [ ! -f ${GIT_PATH} ]
	then
		echo "git is not installed on your system."
		echo "Please use software package manager like apt-get or yum to install it"
		exit 1
	fi
}

test_git_proxy () {
	GIT_PROXY=`env | grep ^GIT_PROXY_COMMAND | cut -d'=' -f2`
	GIT_CONFIG=`grep gitproxy ~/.gitconfig | cut -d'=' -f2`
	if [ -z ${GIT_CONFIG} -a -z ${GIT_PROXY} ]
	then
		git_proxy_warn
	fi
}

test_python () {
	# Checking if python is installed on system
	PYTHON_PATH=`whereis python | cut -d' ' -f2`
	if [ ! -f $PYTHON_PATH ]
	then
		echo "python is not installed on your system."
		echo "Please use software package manager like apt-get or yum to install it"
		exit 1
	fi
}

test_network_fetching () {
	# Checking if you are not behind corporate proxy and have not setup
	# your proxy correctly
	HTTP_PATH='http://git.yoctoproject.org/cgit/cgit.cgi/meta-jarvis/tree/meta-jarvis'
	TEST_FILE="jarvis.bb"
	wget -T 10 $HTTP_PATH/${TEST_FILE}

	if [ ! -f ${TEST_FILE} ]
	then
		network_proxy_error
	else
		echo "SUCCESS: wget test is healthy."
		rm ${TEST_FILE}
	fi
}

clone_linux_stable () {
	cur_dir=$(pwd)
	STABLE_GIT_REPO="git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git"
	if [ ! -d "repo-ext/linux-stable" ]
	then
		echo "Creating new linux-stable"
		mkdir -p repo-ext/linux-stable
		cd repo-ext/linux-stable
		git init
		git remote add -t master -t linux-${KVER}.y origin ${STABLE_GIT_REPO}
		git fetch origin
		# linux-yocto recipe expect master branch to exist at do_kernel_checkout
		git checkout -b master --track origin/master
		git checkout -b linux-${KVER}.y --track origin/linux-${KVER}.y
	else
		cd repo-ext/linux-stable
		echo "Updating linux-stable"
		git fetch origin
	fi
	cd ${cur_dir}
}

create_linux () {
	cur_dir=$(pwd)
	cd ${cur_dir}/repo-ext/linux-stable
	git checkout linux-${KVER}.y
	git reset --hard HEAD
	cd ${cur_dir}
}

apply_linux_kernel_patch () {
	cur_dir=$(pwd)
	cd repo-ext/linux-stable
	BASE_BRC_ON=$(git branch | grep "linux-${KVER}.y" | grep "\*" | wc -l)
	if [ $BASE_BRC_ON -eq 1 ]; then
		echo "Linux linux-${KVER}.y branch ready for patching ..."
		git am $cur_dir/setup/patchset/linux-kernel/*.patch
	fi
	LOCAL_LINUX_BRANCH=$(git branch | grep "linux-${KVER}.y" | cut -c2- | sed -e "s#\s*##g")
	cd ${cur_dir}
}

apply_bsp_meta_patch () {
	cur_dir=$(pwd)
	echo "BSP meta layer patching ..."
	git am $cur_dir/setup/patchset/bsp-meta/*.patch
	cd ${cur_dir}
}

set_local_linux_yocto () {
	linux_recipe="meta-intel-quark/recipes-kernel/linux/linux-yocto-quark_${KVER}.bb"
	LOCAL_LINUX_YOCTO="$cur_dir/repo-ext/linux-stable"
	echo "Setting linux-yocto-quark to local repo downloaded..."
	sed -e "s#LINUX_YOCTO_REPO#${LOCAL_LINUX_YOCTO}#g" ${linux_recipe} > tmp.file
	cat tmp.file > ${linux_recipe}
	rm tmp.file
	echo "Setting linux-yocto-quark to local branch ..."
	sed -e "s#LINUX_YOCTO_BRANCH#${LOCAL_LINUX_BRANCH}#g" ${linux_recipe} > tmp.file
	cat tmp.file > ${linux_recipe}
	rm tmp.file
	git add ${linux_recipe}
	git commit -s -m "meta-intel-quark: set linux-yocto to local repo & branch"
}

apply_combined_repo_commit () {
	echo   "Initial Repo Population: Quark for linux-yocto ver-${KVER}" > VERSION.txt
	printf "\nCombo-layer configuration:\n" >> VERSION.txt
	cat setup/combolayer-quark.conf >> VERSION.txt
	cat VERSION.txt
	git commit -F VERSION.txt
}

# Run a series of test to make sure that we can perform the repo setup
test_python
test_network_fetching
test_git
test_git_proxy

# Finally start fetching all source code from external repo
# and combine them to form a buildable project

echo "Fetching in a local git repo of linux-yocto"
clone_linux_stable
create_linux
apply_linux_kernel_patch

echo "Fetching in Quark v1.2 ingredient Now"
setup/combo-layer -c setup/combolayer-quark.conf init
apply_combined_repo_commit
apply_bsp_meta_patch
set_local_linux_yocto

echo "========================================================================="
echo "By default, this setup script will create a brand new repo which combines"
echo "meta-intel BSP layer and Yocto Project poky distro.                      "
echo "If you don't need git tracking, please 'rm -rf .git' now                 "
echo "========================================================================="

exit 0
