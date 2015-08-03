#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
echo "deb http://http.us.debian.org/debian unstable main non-free contrib" >> /etc/apt/sources.list
echo "Package: *"  > /etc/apt/preferences.d/pin_unstable
echo "Pin: release a=unstable" >> /etc/apt/preferences.d/pin_unstable
echo "Pin-Priority: -99" >> /etc/apt/preferences.d/pin_unstable
apt-get update
apt-get install -y pbuilder gdb lua5.1 stow
apt-get install -y libconfig-model-dpkg-perl libconfig-model-itself-perl devscripts git-buildpackage svn-buildpackage
apt-get install -y help2man git-buildpackage svn-buildpackage subversion git
apt-get install -y -t unstable cme lintian
cd /home/vagrant
git clone https://github.com/satta/dotfiles.git
cd /home/vagrant/dotfiles
rm -rf /home/vagrant/.pbuilder*
stow pbuilder
rm -rf /home/vagrant/.zshrc
stow zsh
stow git
stow debian
rm -rf /home/vagrant/.ccache
stow ccache
ln -fs /homedir/.gnupg /home/vagrant
cp /homedir/.ssh/id_rsa* /home/vagrant/.ssh
mkdir -p /var/cache/pbuilder
cp /homedir/uni/debian-work/pbuilder-base/sid-amd64-base.tgz /var/cache/pbuilder
ln -sf /home/vagrant/.pbuilder* /root
DIST=sid pbuilder --update
