#!/usr/bin/env bash
set -x

# Vagrant provision script for installing bbufr

# Install rave depencies
sudo apt-get install -qq libproj0
sudo apt-get install -qq proj-bin
sudo apt-get install -qq libproj-dev

# Install rave from source
cd ~
mkdir tmp
cd tmp
cp /vagrant/vendor/bufr-opera-mf-1.21.tar.gz .
tar xfz bufr-opera-mf-1.21.tar.gz
rm bufr-opera-mf-1.21.tar.gz 
cd bufr-opera-mf-1.21/
./configure --prefix=/opt/bufr
make
cd tests
make check
cd ..
sudo make install

# copy decbufr and tables
cd tests
sudo mkdir /opt/bufr/bin
sudo cp decbufr /opt/bufr/bin/
sudo chmod +x /opt/bufr/bin/decbufr
cd ../tables
sudo cp *.csv /opt/bufr/bin/

echo "export BUFRLIB=\"/opt/bufr/bin/\"" >> ~/.bashrc
