# Lab 2

**Table of Contents**

- [Setup AWS Environment](##setup-aws-environment)
- [Install and Configure Splunk](##install-and-configure-splunk)
- [Install Rails Goat](##install-rails-goat)
- [Run Rails Goat](##run-the-goat)

# Manually Deploy a Vulnerable App

---

## Setup AWS Environment

Using the script developed during the last lab, open the AWS Console.

E.g.,

```
assumer -a 717986480831 -r human/dso/TGT-dso-DeploymentAdmin \
  -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-DeploymentAdmin \
  -p dso -g -u student1
```

1. Generate an SSH Key

 On the AWS Console, select `Services` > `EC2`, make sure you are using the Oregon region, you can do this by selecting the region from the upper right section of the console. Select `Key Pairs` > `Create Key Pair`. Enter in your student username for the `Key pair name` and click `Create`. Save the file to a secure location.

2. Create a Security Group

 Select `Security Groups` from the AWS Console. Click `Create Security Group`, enter "STUDENT_ID-web-ports" for `Security group name` and "Web Ports for App" for `Description`. Under security group rules, click `Add Rule` and add a rule for SSH, another for TCP/8080. Under source, select `My IP`.

 Note: never use `0.0.0.0/0` or `Anywhere` for the source setting.

3. Launch an Instance

 Using the AWS Web Console launch a t1.micro RHEL instance. Use the Oregon region (us-west-2), you can do this by selecting the region from the upper right section of the console.

 From the AWS Console, select `Services` > `EC2`. Click `Launch Instance`. Select `Red Hat Enterprise Linux 7.2 (HVM)`, select `m3.medium` > click `Next: Configure Instance Details` (Select a **Public** subnet and set `Auto-assign Public IP` to `Enable`) > `Next: Add Storage` > `Next: Tag Instance` (tag it with your student username) > `Next: Configure Security Group`. Select existing security group, choose the security group you created above. Click Review and Launch, click Launch, select the key pair you created above and click `Launch Instance`.

4. SSH into your AWS host. You can find the public IP address by selecting your instance and looking for the `Public IP` field.

 E.g.,

 ```
$ ls -l ~/Downloads/student1.pem
$ chmod 600 ~/Downloads/student1.pem
$ ssh -i ~/Downloads/student1.pem ec2-user@54.x.x.x
 ```

## Install and Configure Splunk

1. Install/configure dependencies, download and install Splunk.

 ```
$ sudo timedatectl set-timezone UTC
$ sudo yum -y install wget
$ wget -O splunkforwarder-6.4.1-debde650d26e-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.4.1&product=universalforwarder&filename=splunkforwarder-6.4.1-debde650d26e-linux-2.6-x86_64.rpm&wget=true'
$ sudo rpm -ivh splunkforwarder-6.4.1-debde650d26e-linux-2.6-x86_64.rpm
 ```

2. Configure Splunk.

 Configure outputs:


 ```
echo "[tcpout]
defaultGroup = dso-autolb-group

[tcpout:dso-autolb-group]
disabled = false
dropEventsOnQueueFull = 10
server = appliance:9997
sslCertPath = \$SPLUNK_HOME/etc/auth/server.pem
sslPassword = password
sslRootCAPath = \$SPLUNK_HOME/etc/auth/cacert.pem
sslVerifyServerCert = false
useACK = false" | sudo tee /opt/splunkforwarder/etc/system/local/outputs.conf
 ```

 Configure inputs:

 ```
echo "[default]
host = \$decideOnStartup


[monitor:///home/ec2-user/railsgoat/log/]
recursive=true

[monitor:///var/log/]
recursive=true" | sudo tee /opt/splunkforwarder/etc/system/local/inputs.conf
 ```

 Start Splunk:
 ```
sudo /opt/splunkforwarder/bin/splunk start
 ```

## Install Rails Goat

1. Install dependencies.

 ```
$ sudo yum -y install git git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
$ sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
$ sudo yum -y install nodejs
$ sudo yum -y install mariadb mariadb-server mariadb-devel
$ sudo systemctl start mariadb.service
 ```

2. Install Ruby.

 ```
$ cd
$ git clone git://github.com/sstephenson/rbenv.git .rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

$ git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
$ echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile

$ source ~/.bash_profile
$ rbenv install -v 2.3.1
$ rbenv global 2.3.1
 ```

3. Install bundler.

 ```
$ ruby -v
$ gem install bundler --no-ri --no-rdoc
 ```

4. Setup Rails Goat.

 ```
$ cd ~
$ git clone https://github.com/OWASP/railsgoat.git
$ cd railsgoat
$ touch log/mysql.log
$ export RAILS_ENV=mysql
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
 ```

## Run Rails Goat

1. Run the app.

  ```
  bundle exec rails server -b 0.0.0.0 -p 8080
  ```

  Load `http://VM_IP_ADDRESS:8080` on your browser. You may need to run `ifconfig` to find out your VM's IP address.
