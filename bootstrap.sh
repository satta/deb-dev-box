#!/usr/bin/env bash

# quick'n'dirty provisioning -- this isn't particularly elegant
# but will do for now

# use unstable too please
export DEBIAN_FRONTEND=noninteractive
echo "deb http://http.us.debian.org/debian unstable main non-free contrib" >> /etc/apt/sources.list
echo "Package: *"  > /etc/apt/preferences.d/pin_unstable
echo "Pin: release a=unstable" >> /etc/apt/preferences.d/pin_unstable
echo "Pin-Priority: -99" >> /etc/apt/preferences.d/pin_unstable
apt-get update

# install base dev packages
apt-get install -y pbuilder gdb lua5.1 stow libconfig-model-dpkg-perl \
                   libconfig-model-itself-perl devscripts git-buildpackage \
                   svn-buildpackage help2man subversion git build-essential \
                   gnupg reportbug libgenometools0-dev libcairo2-dev vim zsh
apt-get install -y -t unstable cme lintian

# dotfiles
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

# use zsh
chsh -s /usr/bin/zsh vagrant

# GPG keys
ln -fs /homedir/.gnupg /home/vagrant

# SSH keys
cp /homedir/.ssh/id_rsa* /home/vagrant/.ssh
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*

# sid base tarball for pbuilder
mkdir -p /var/cache/pbuilder
cp /homedir/uni/debian-work/pbuilder-base/sid-amd64-base.tgz /var/cache/pbuilder
ln -sf /home/vagrant/.pbuilder* /root
DIST=sid pbuilder --update
