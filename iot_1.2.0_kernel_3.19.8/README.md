Brief
====
* Base: [BSP 1.2.0](https://downloadcenter.intel.com/download/23197/Intel-Quark-BSP)
* Kernel: 3.19.y (3.19.8 on 12.12.2015)


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


Versions
====

2015-12-28:
* Linux Image based on this code and with more features is available [here](https://github.com/xbolshe/galileo-custom-images/tree/master/iot_1.2.0_kernel_3.19.8)

2015-12-12:
* First public release
* Linux Image sample based on this code is available [here](https://relvarsoft.com/galileo/galileo_iot_1.2.0_custom_build_xbolshe_kernel_v3.19.8_201512121.zip)

xbolshe
