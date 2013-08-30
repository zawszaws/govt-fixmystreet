#!/bin/sh
set -e
set -x

# This is a provision script that will take a fresh vagrant box and prepare it
# to be used as a development environment. It does not prepare the box for
# running as a server - for that you should look at
# http://code.fixmystreet.com/install/install-script/


# Change to the repo dir so that paths can be relative
cd /vagrant/fixmystreet/


# Update apt-get first
apt-get update -y


# set up locales and set the en_gb.UTF-* one
apt-get install -y language-pack-en || true
echo 'LANG="en_GB.UTF-8"' > /etc/default/locale
export LANG="en_GB.UTF-8"


# generate additional locales for the tests
locale-gen cy_GB.UTF-8
locale-gen nb_NO.UTF-8


# Install system packages we'll need
xargs -a conf/packages.ubuntu-precise apt-get -y install


# Ruby deps (not packaged as debs)
gem install compass


# Create the database user and the database
sudo -u postgres psql     -c "CREATE USER vagrant WITH PASSWORD 'secret';"
sudo -u postgres psql     -c "CREATE DATABASE fms WITH OWNER vagrant;"


# become the vagrant user for the remaining install
su - vagrant -c /vagrant/fixmystreet/bin/provision-as-vagrant.sh
