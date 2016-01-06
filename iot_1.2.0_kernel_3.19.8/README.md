Brief
====
* Base: [BSP 1.2.0](https://downloadcenter.intel.com/download/23197/Intel-Quark-BSP)
* Kernel: 3.19.y (3.19.8 on 12.12.2015) from kernel.org
* Kernel patches: my custom patches adapted for this Kernel version


Installation using GIT
====

Create a folder and execute the following commands using non-root account:

``` bash
git init
git config user.name "user"
git config user.email "user@mail.local"
git remote add origin https://github.com/xbolshe/galileo-sources.git
git pull -u origin master
cd iot_1.2.0_kernel_3.19.8
chmod +x *.sh
chmod +x setup/combo-layer
./setup.sh
```

Manual installation
====

Create a folder and execute the following commands using non-root account:

``` bash
1. Unzip galileo-sources-master.zip to a folder 
2. $ cd iot_1.2.0_kernel_3.19.8
3. Add execution rights
      $ chmod +x *.sh 
      $ chmod +x setup/combo-layer
4. Using the root account execute
      # ./packets.sh
   to install required packets
5. Setup git account. Or use default account like shown below:
      $ git config --global user.name "user"
      $ git config --global user.email "user@mail.local"
6. Using non-root account execute
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
* Changelog is available [here](https://github.com/xbolshe/galileo-sources/tree/master/iot_1.2.0_kernel_3.19.8/changelog.txt)


SD Card Linux Images
====

Samples of SD Card Linux Images based on this code are available to download below:

* Linux Image based on this code and with more features (like NodeJS, SQLite3, MRAA, UPM, etc.) is available [here](https://github.com/xbolshe/galileo-custom-images/tree/master/iot_1.2.0_kernel_3.19.8)
* Linux Image sample based on this code is available [here](https://relvarsoft.com/galileo/galileo_iot_1.2.0_custom_build_xbolshe_kernel_v3.19.8_201512121.zip)


xbolshe
