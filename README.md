READ THIS FIRST
===============

Things have changed since this script was written. There is now a better way to install latest version of Eclipse IDE in Ubuntu, called `umake` [ubuntu-make](https://github.com/ubuntu/ubuntu-make).
In short, you only need one command to install (and also remove) Eclipse now:

```bash
umake ide eclipse
```
You still can use this project for other distributions of Linux and non-standard situations.

Eclipse Installer
=================

Simple installation script for Eclipse (Linux only).
Based on this comment http://askubuntu.com/questions/26632/how-to-install-eclipse/219974#219974 from maggotbrain (thank you!)

Just download the .tar.gz distribution of Eclipse (hope it works with any version).

In case of problems feel free to create an issue.

INSTALL
=======

Just clone the repo:

```bash
git clone https://github.com/bepcyc/eclipse_installer
```

RUN
===

Chmod if you need it:

```bash
chmod +x eclipse_installer.sh
```

Put downloaded .tar.gz file into the same directory as script.
Run the script:

```bash
./eclipse_installer.sh
```

or

```bash
./eclipse_installer.sh --quiet
```

If you don't want it to be verbose.

Run the Eclipse:

```bash
/usr/bin/eclipse -clean &
```

Enjoy!


