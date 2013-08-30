#!/bin/sh
set -e

# This script is run as the 'vagrant' user from the main provision script.

cd /vagrant/fixmystreet

# set up the database
psql fms < db/schema.sql
psql fms < db/generate_secret.sql
psql fms < db/alert_types.sql


# Install Perl module dependencies (quite a few...)
bin/install_perl_modules


# symlink in the pre-canned config
$( cd conf; ln -s general.yml-vagrant general.yml)


# generate the CSS
bin/make_css


# generate the translations
commonlib/bin/gettext-makemo FixMyStreet


# Run the test suite
bin/cron-wrapper prove -r t


# run the dev server
echo <<END_TIPS
Installation complete!

You should now run the following commands:

> vagrant ssh
> cd /vagrant/fixmysteet
> bin/cron-wrapper script/fixmystreet_app_server.pl -d -r --fork

Note: to get a fully up and running system, you may want to run bin/cron-wrapper bin/update-all-reports after you login

END_TIPS
