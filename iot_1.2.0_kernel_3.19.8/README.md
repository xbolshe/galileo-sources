Brief
====
* Base: [BSP 1.2.0](https://downloadcenter.intel.com/download/23197/Intel-Quark-BSP)
* Kernel: 3.19.y (3.19.8 on 12.12.2015) from kernel.org
* Kernel patches: my custom patches adapted for this Kernel version


Installation using GIT
====

Create a folder and execute the following commands using non-root account:

``` bash
sudo apt-get install git
git init
git config --global user.name "user"
git config --global user.email "user@mail.local"
git remote add origin https://github.com/xbolshe/galileo-sources.git
git pull -u origin master
cd iot_1.2.0_kernel_3.19.8
chmod +x *.sh
chmod +x setup/combo-layer
sudo ./packets.sh
./setup.sh
```

Manual installation
====

Create a folder, unzip galileo-sources-master.zip and execute the following commands using non-root account:

``` bash
$ cd iot_1.2.0_kernel_3.19.8
$ chmod +x *.sh 
$ chmod +x setup/combo-layer
$ sudo ./packets.sh
$ git config --global user.name "user"
$ git config --global user.email "user@mail.local"
$ ./setup.sh
```

Compiling
====

``` bash
1. Execute using non-root account: 
     $ source ./oe-init-build-env build
2. Edit files as needed
     ./build/conf/local.conf
     ./build/conf/bblayers.conf
3. Go to a directory
     ./build
4. Compile it using non-root account
     $ bitbake image-full
5. Take files from
     ./build/tmp/deploy/images/quark
```

Changelog
====
* Changelog is available [here](https://github.com/xbolshe/galileo-sources/tree/master/iot_1.2.0_kernel_3.19.8/changelog.md)


SD Card Linux Images
====

Samples of SD Card Linux Images based on this code are available to download below:

* Featured Linux Image based on this code and with more features (like NodeJS, SQLite3, MRAA, UPM, etc.) is available [here](https://github.com/xbolshe/galileo-custom-images/tree/master/iot_1.2.0_kernel_3.19.8)
* Basic Linux Image based on this code is available [here](https://relvarsoft.com/galileo/galileo_xbolshe_iot_1.2.0_kernel_v3.19.8_basic_201601071.zip)



xbolshe
