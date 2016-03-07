#!/usr/bin/env bash

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
                   gnupg reportbug libgenometools0-dev libcairo2-dev vim zsh \
                   cowbuilder cowdancer ccache valgrind aptitude \
                   quilt htop autopkgtest debci python-stdeb python3-stdeb \
                   gitk git-gui mbr vmdebootstrap signing-party
apt-get install -y -t unstable cme lintian

# dotfiles
cd /home/vagrant
git clone https://github.com/satta/dotfiles.git
cd /home/vagrant/dotfiles
rm -rf /home/vagrant/.pbuilder*
stow pbuilder
sudo ln -s /home/vagrant/.pbuilderrc /root
rm -rf /home/vagrant/.zshrc
stow zsh
stow git
stow debian
stow ssh
stow caff
rm -rf /home/vagrant/.ccache
stow ccache

# use zsh
chsh -s /usr/bin/zsh vagrant

# GPG directory
cp -prv /homedir/.gnupg /home/vagrant
sed -i 's/^keyserver-options ca-cert-file.*/keyserver-options ca-cert-file=\/home\/vagrant\/.gnupg\/sks-keyservers.netCA.pem/g' /home/vagrant/.gnupg/gpg.conf

# SSH keys
ln -fs /homedir/.ssh /home/vagrant/.ssh/satta

# make local package directory
mkdir /home/vagrant/_pbuilder_local_deps

# give vagrant subdirectory to user
chown -R vagrant:vagrant /home/vagrant

# create base image for git-pbuilder/cowbuilder (nice to use with gbp)
#mkdir /var/cache/pbuilder/base.cow
#DIST=sid pbuilder create --configfile /home/vagrant/.pbuilderrc \
#	  --buildplace /var/cache/pbuilder/base.cow \
#		--mirror http://httpredir.debian.org/debian/ \
#		--architecture amd64 --distribution sid --no-targz \
#		--extrapackages cowdancer

# create base image for debci/adt
#debci setup
#cat <<EOF > /etc/schroot/chroot.d/debci-unstable-amd64
#[debci-unstable-amd64]
#type=directory
#profile=debci
#description=debci unstable/amd64 chroot
#directory=/usr/share/debci/chroots/debci-unstable-amd64
#users=debci,vagrant
#groups=debci
#root-users=debci,vagrant
#source-root-users=debci,vagrant
#root-groups=root
#union-type=aufs
#union-overlay-directory=/dev/shm
#EOF

