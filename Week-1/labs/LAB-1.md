# Lab 1

## Setting up your Github Account

If you already have a Github account please help the other people on your team to follow the instructions and get their accounts set up.

Register for a Github account at https://github.com/join

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
ssh-keygen -t rsa -C YOUR_EMAIL@DOMAIN.COM
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

## Configuring Git on Windows
If you don't have git installed on your Windows computer you can install it from https://git-scm.com/download/win

- On your computer, open the **Git Bash** application.
Set git to use your name and an email address so your git commits will be properly labeled.
```
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR EMAIL ADDRESS"
```
If you want to keep your email address private, see ["Keeping your email address private".](https://help.github.com/articles/keeping-your-email-address-private")
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
- Go to your [Github Settings](https://github.com/settings/keys"), click **New SSH Key** button, provide a **Title** and paste in the public SSH Key, then click **Add SSH Key**.

---

## Security is Everyone's Responsibility
Take 5 minutes to go through the Federal Trade Commission's Start with Security document available here at

https://www.ftc.gov/system/files/documents/plain-language/pdf0205-startwithsecurity.pdf

Pick one issue that you feel is important.

Contribute to the Raindance project using Github.

## Open Contribution

A huge part of DevSecOps is the Open Contribution model. By opening up the contribution to a project we take advantage of the ability to move faster through collaboration. One of the projects we are working hard on getting Open Contribution iterating on is [Raindance] (https://github.com/devsecops/raindance)

Take the issue that you identified from the FTC document to think through how this issue maps back to the Raindance attack model. Determine the attacker type, attack vector and the service type.
