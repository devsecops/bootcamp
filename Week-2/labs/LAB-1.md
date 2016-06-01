# Lab 1

**Table of Contents**

- [Basic commands](##basic-commands)
- [The Filesystem](##the-filesystem)
- [Users and sudo](##users-and-sudo)
- [Yum, Installing Packages](##yum-installing-packages)
- [The network](##the-network)

# Lightning fast intro to Linux/CentOS 7

Let's get into our Linux VM:

```
$ cd ~/dso_repos/bootcamp/
$ # vagrant provision
$ # vagrant up
$ vagrant ssh
```

---

## Basic CommandsDownload a word list, move it into, its own directory, decompress the word list and count the words.
```
$ wget http://download.openwall.net/pub/wordlists/all.gz
$ mkdir words
$ mv all.gz words/
$ cd words
$ gunzip all.gz
$ ls -l
$ wc -l all
```

Count the number of words that start with the first letter of your last name. E.g., if my last name starts with a 'g' I would do the following:

```
$ grep -e '^g.*' all |wc -l
```


Create a new text file using vim, nano, or cat. Then, count the words, 

```
$ cat > file.txt
this is my file, there are many like it but this one is mine...
^D
```
## The Filesystem

Listing the root filesystem:

```
$ ls -l /
$ ls /bin
```

Permissions, here we see that the `ls` command has read-write-execute permissions for root, and read-execute for everyone else.

```
$ ls -l /bin/ls
  -rwxr-xr-x. 1 root root 117616 Feb 16 10:49 /bin/ls
```

Relative paths vs full paths.

```
$ ls -l home
$ ls -l /home
$ ls -la
```

Most important directories: /etc (configuration), /home (user directories), /var (logs & other), /bin (commands).

```
$ ls -ld /etc /home /var /bin
```

## Users and sudo

Who am I?

```
$ whoami
$ ls -la
```

Create a user in /etc as a non-privileged user. Did it work?

```
$ touch /etc/myfile.txt
```

Create the file using sudo. Why did it work?

```
$ sudo touch /etc/myfile.txt
```

So, what happens when we use sudo?

```
$ sudo whoami
```

Let's take a look at /etc/passwd, list all the system usernames.
```
$ cat /etc/passwd
$ cat /etc/passwd| cut -f1 -d:
```

List the root users:

```
grep 'x:0:' /etc/passwd
```

## Yum, Installing PackagesDid anyone try using nano? Is it installed? Let's install it:

```
yum install nano
```

What went wrong? how do we fix it?

## The NetworkLet's install net-tools:```
sudo yum -y install net-tools
```

Now we can list our IP address, list our network routes, and list open ports.

```
$ ifconfig
$ route
$ netstat -na
```

How would you list the TCP listening ports? Do it two ways, one just using `netstat` and the other using `grep`.
