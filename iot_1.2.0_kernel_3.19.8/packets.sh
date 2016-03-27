#!/bin/sh

######################################
### use root account to execute it ###
######################################

############################
# install required packets #
############################

apt-get install git gcc-multilib texinfo
apt-get install diffstat gawk chrpath file
apt-get install build-essential uuid-dev iasl
apt-get install subversion nasm autoconf
apt-get install gnu-efi qemu libsdl1.2-dev
apt-get install xterm

###############################################
### uncomment it to use default git account ###
###############################################
#git config --global user.name "user"
#git config --global user.email "user@mail.local"
