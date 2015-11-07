# deb-dev-box

This is a Vagrant setup that makes for a nice environment for Debian packaging
on non-Linux systems (e.g. Mac OS X). Generic boxes for this purpose often do
not provide enough available space for more involved packaging. I have found
especially the build directories (e.g. created by pbuilder) and space used by
the build dependencies for diverse packaging projects to be too much for off-
the-shelf boxes. Also, pbuilder creates dev nodes and links inside its build
directories, so simply using shared folders on the host does not work.

## Prerequisites

This requires an installed Jessie base box, e.g. built using
https://github.com/dotzero/vagrant-debian-jessie-64 -- the nice thing about the
above is that it has 40GB of space.

It might be helpful to install the `vagrant-vbguest` plugin:

    $ vagrant plugin install vagrant-vbguest

## Bundled software

* dev stuff: build-essential, gdb, valgrind, ccache
* the usual: cowdancer, cowbuilder
* GnuPG
* zsh
* reportbug
* GNU stow
* git-buildpackage, svn-buildpackage
* help2man
* cme, lintian (from unstable)

Unstable is in `sources.list` but pinned to -99 priority, use `aptitude -t
unstable` to force installation from unstable.

An unstable cow dancer image is created as part of provisioning, as is GnuPG key
deployment. Dot files are cloned from GitHub and linked via stow.
