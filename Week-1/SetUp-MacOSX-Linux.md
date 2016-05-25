# Mac OS X & Linux

---

## Homebrew (OS X package manager)
If you don't have [Homebrew](http://brew.sh/) or any other Mac OS X package manager:
- Install:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
```

---

## Git
If you don't have [Git](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics):
- [OS X] Install:
```
brew update
brew install git
```
- [Debian] Install:
```
sudo apt-get update
sudo apt-get install -y git
```
- [RHEL/CENTOS] Install:
```
sudo yum update -y
sudo yum install -y git
```
- Configure:
```
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR EMAIL"
```
- Generate SSH Keys:
```
ssh-keygen -t RSA -C YOUR_EMAIL@DOMAIN.COM
```
- You'll receive the following prompts:  
  `Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):` - Press Enter  
  `Enter passphrase (empty for no passphrase):` - Enter Password  
  `Enter same passphrase again:` - Confirm Password  
- You should receive the following confirmation:
```
Your identification has been saved in /home/vagrant/.ssh/id_rsa.
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
...
```
- Print out the Public SSH Key & copy it: 
```
cat ~/.ssh/id_rsa.pub
```
- Go to your [Github Settings](https://github.com/settings/keys), click **New SSH Key** button, enter a **Title** and paste in the public SSH Key, then click **Add SSH Key**.

---

## Virtualbox
If you don't have [Virtualbox](https://www.virtualbox.org/wiki/Downloads):
- Download and install the appropriate binary for your operating system and architecture from [Virtualbox Downloads](https://www.virtualbox.org/wiki/Downloads)

---

## Vagrant
[Vagrant](https://www.vagrantup.com/) is a DevOps tool that enables developers to stand-up & provision virtual machines with extreme ease. All you need is a `Vagrantfile` that describes the virtual machine (e.g. Guest OS, virtual CPUs, virtual RAM, what packages must be installed when the virtual machine is online ...etc) and `vagrant` will take care of the rest for you.
- Download and install the appropriate binary for your operating system and architecture from [Vagrant Downloads](https://www.vagrantup.com/downloads.html)
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
vagrant up
```
- Depending on your hardware, this process may take 10 minutes to complete. Once complete, connect to the virtual machine: 
```
vagrant ssh
```
---

## References:
- Git: https://help.github.com/articles/set-up-git/#platform-windows
- VirtualBox: https://www.virtualbox.org/wiki/Downloads
- Vagrant: https://www.vagrantup.com/
- Ruby Environment Manager (`rbenv`): https://github.com/rbenv/rbenv
- AWS CLI: https://aws.amazon.com/cli/
