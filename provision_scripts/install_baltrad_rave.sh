#!/usr/bin/env bash
set -x

# Vagrant provision script for installing BALTRAD RAVE component

# Install RAVE depencies
sudo apt-get install -qq libproj0
sudo apt-get install -qq proj-bin
sudo apt-get install -qq libproj-dev
sudo apt-get install -qq expat
sudo apt-get install -qq libexpat-dev
sudo apt-get install -qq libpython2.7-dbg

export LD_LIBRARY_PATH=/opt/baltrad/hlhdf/lib

# Install RAVE from source
cd ~
cd tmp
git clone --depth=1 git://git.baltrad.eu/rave.git
cd rave
./configure --prefix=/opt/baltrad/rave --with-hlhdf=/opt/baltrad/hlhdf --with-proj=/usr/include,/usr/lib --with-expat=/usr/include,/lib/x86_64 --with-bufr=/opt/baltrad/bbufr --with-numpy=/usr/lib/python2.7/dist-packages/numpy/core/include/numpy/
make
make test
make install

echo "export PATH=\"\$PATH:/opt/baltrad/rave/bin\"" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\"\$LD_LIBRARY_PATH:/opt/baltrad/rave/lib\"" >> ~/.bashrc
