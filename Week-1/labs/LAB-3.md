# Lab 3

**Table of Contents**  

- [Mac OS X & Linux Set-up](#mac)
- [Windows Set-up](#windows)

#Mac OS X & Linux

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

# Windows 

Windows 7 or later

---
## Installing Git for Windows

You can install `git` on Microsoft Windows 7 or later by downloading and installing the `git` Windows binary found on [git-scm](https://git-scm.com/download/win target="_blank"):
- You should be automatically prompted to download the installer.
  - If not, select the right installer for your OS architecture (32-bit vs 64-bit)
- In your computer's **Downloads** folder, double-click `Git-2.8.3-64-bit.exe`
- Proceed through the prompts with the default options, click **Install**
- After the program has been installed, you should now be able to use `git` in **cmd.exe**.
- You will also have a new application called `Git Bash`, which is a wrapper that gives you the same command-line experience as you would on a Linux or Mac OS X terminal.

## Configuring Git on Windows
- On your computer, open the **Git Bash** application.
Set git to use your name and an email address so your git commits will be properly labeled.
```
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR EMAIL ADDRESS"
```
If you want to keep your email address private, see ["Keeping your email address private".](https://help.github.com/articles/keeping-your-email-address-private_ target="_blank")
- Generate SSH Keys: `ssh-keygen -t RSA -C your_email@example.com`
- You'll receive the following prompts:  
  `Enter file in which to save the key (/c/Users/%username%/.ssh/id_rsa):` - Press Enter  
  `Enter passphrase (empty for no passphrase):` - Enter Password  
  `Enter same passphrase again:` - Confirm Password  
- You should receive the following confirmation:
```
Your identification has been saved in /c/Users/%username%/.ssh/id_rsa
Your public key has been saved in /c/Users/%username%/.ssh/id_rsa.pub
...
```
- Print out the Public SSH Key: `cat ~/.ssh/id_rsa.pub` and copy it
- Go to your [Github Settings](https://github.com/settings/keys target="_blank"), click **New SSH Key** button, provide a **Title** and paste in the public SSH Key, then click **Add SSH Key**.

---

## Installing VirtualBox
- Go to [VirtualBox Downloads](https://www.virtualbox.org/wiki/Downloads target="_blank")
- Download the appropriate installer for your OS (`Windows`) and architecture (32-bit vs 64-bit)
- In **Downloads** folder, launch the installer and follow the prompts, leaving the default options as-is.

---

## Installing Vagrant
[Vagrant](https://www.vagrantup.com/ target="_blank") is a DevOps tool that enables developers to stand-up & provision virtual machines with extreme ease. All you need is a `Vagrantfile` that describes the virtual machine (e.g. Guest OS, virtual CPUs, virtual RAM, what packages must be installed when the virtual machine is online ...etc) and `vagrant` will take care of the rest for you.
- Go to [Vagrant Downloads](https://www.vagrantup.com/downloads.html target="_blank")
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
- Change directory to the `bootcamp` directory and launch the virtual machine:
```
cd bootcamp
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


---

## References:
- Git: https://help.github.com/articles/set-up-git/#platform-windows
- VirtualBox: https://www.virtualbox.org/wiki/Downloads
- Vagrant: https://www.vagrantup.com/
- Ruby Environment Manager (`rbenv`): https://github.com/rbenv/rbenv
- AWS CLI: https://aws.amazon.com/cli/


