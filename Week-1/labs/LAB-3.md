# Lab 3

**Table of Contents**  

- [Mac OS X & Linux Set-up](#mac)
- [Windows Set-up](#windows)
- [Docker](#docker)
- [Resources](#resources)

#Mac OS X & Linux

---

## Homebrew (OS X package manager)
If you don't have [Homebrew](http://brew.sh/) or any other Mac OS X package manager:
- Install:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
```
---

## Virtualbox
If you don't have [Virtualbox](https://www.virtualbox.org/wiki/Downloads) it can be installed using Homebrew
- Open **Terminal** and execute:
```
brew cask install virtualbox
```
However, if you don't like Homebrew, download and install the appropriate binary for your operating system and architecture from [Virtualbox Downloads](https://www.virtualbox.org/wiki/Downloads)

---

## Vagrant
[Vagrant](https://www.vagrantup.com/) is a DevOps tool that enables developers to stand-up & provision virtual machines with extreme ease. All you need is a `Vagrantfile` that describes the virtual machine (e.g. Guest OS, virtual CPUs, virtual RAM, what packages must be installed when the virtual machine is online ...etc) and `vagrant` will take care of the rest for you.

Vagrant installation can be done with Homebrew
- Open **Terminal** and execute:
```
brew cask install vagrant
```
Again, if you don't like Homebrew you can download and install the appropriate binary for your operating system and architecture from [Vagrant Downloads](https://www.vagrantup.com/downloads.html)

- In **Terminal**, you should now have `vagrant` command-line utility available. Type `vagrant` or `vagrant version` to confirm.


## Launching the Vagrant Virtual Machine
- In **Terminal**, make a **dso_repos** directory and clone the `bootcamp` repository into it:
```
mkdir $HOME/dso_repos
cd $HOME/dso_repos
git clone git@github.com:devsecops/bootcamp.git
```
- Change directory to the `bootcamp` directory and launch the virtual machine:
```
cd bootcamp
vagrant plugin install vagrant-vbguest
vagrant up
```
- Depending on your hardware, this process may take 10 minutes to complete. Once complete, connect to the virtual machine:
```
vagrant ssh
```

If, after you SSH, you notice that
```
aws configure
```
has no output, you may need to run
```
vagrant provision
```

This should run all of the extra commands in the Vagrantfile (Installing Ruby, Python, AWS CLI, etc.)
---

# Windows

Windows 7 or later

---
## Installing Git for Windows

You can install `git` on Microsoft Windows 7 or later by downloading and installing the `git` Windows binary found on [git-scm](https://git-scm.com/download/win):
- You should be automatically prompted to download the installer.
  - If not, select the right installer for your OS architecture (32-bit vs 64-bit)
- In your computer's **Downloads** folder, double-click `Git-2.8.3-64-bit.exe`
- Proceed through the prompts with the default options, click **Install**
- After the program has been installed, you should now be able to use `git` in **cmd.exe**.
- You will also have a new application called `Git Bash`, which is a wrapper that gives you the same command-line experience as you would on a Linux or Mac OS X terminal.
## Installing VirtualBox
- Go to [VirtualBox Downloads](https://www.virtualbox.org/wiki/Downloads)
- Download the appropriate installer for your OS (`Windows`) and architecture (32-bit vs 64-bit)
- In **Downloads** folder, launch the installer and follow the prompts, leaving the default options as-is.

---

## Installing Vagrant
[Vagrant](https://www.vagrantup.com/) is a DevOps tool that enables developers to stand-up & provision virtual machines with extreme ease. All you need is a `Vagrantfile` that describes the virtual machine (e.g. Guest OS, virtual CPUs, virtual RAM, what packages must be installed when the virtual machine is online ...etc) and `vagrant` will take care of the rest for you.
- Go to [Vagrant Downloads](https://www.vagrantup.com/downloads.html)
- Download the Windows installer.
- In **Downloads** folder, launch the installer and follow the prompts, leaving the default options as-is.
- The installer will prompt you for a reboot when complete. Click the Reboot now option.
- In **Git Bash**, you should now have `vagrant` command-line tool available. Type `vagrant` or `vagrant version` to confirm.

## Launching the Vagrant Virtual Machine
- In **Git Bash**, make a **dso_repos** directory and clone the bootcamp repository into it:
```
mkdir dso_repos
cd dso_repos
git clone git@github.com:devsecops/bootcamp.git
```
- Change directory to the `bootcamp` directory, install a vagrant plugin, and launch the virtual machine:
```
cd bootcamp
vagrant plugin install vagrant-vbguest
vagrant up
```
- Depending on your hardware, this process may take 10 minutes to complete. Once complete, connect to the virtual machine:  
`vagrant ssh`
- To validate all packages were installed type:  
  `aws configure`  
The expected output looks like this:
  ```
  AWS Access Key ID [None]:
  AWS Secret Access Key [None]:
  Default region name [None]:
  Default output format [None]:

  ```


#Docker
If you are comfortable with docker, you may use the docker-image either by building it yourself from the Dockerfile at the root of the bootcamp repository, or using a prebuilt image.
In the interim: there is a non-official image at [colinross/bootcamp](https://hub.docker.com/r/colinross/bootcamp/)

[https://docs.docker.com/](https://docs.docker.com/) is a great place to start with learning more about docker.

---

## Resources:
- Git: https://help.github.com/articles/set-up-git/#platform-windows
- VirtualBox: https://www.virtualbox.org/wiki/Downloads
- Vagrant: https://www.vagrantup.com/
- Ruby Environment Manager (`rbenv`): https://github.com/rbenv/rbenv
- AWS CLI: https://aws.amazon.com/cli/
- [Linux File System permissions for secret keys](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)
