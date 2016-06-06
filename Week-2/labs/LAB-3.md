# Lab 3

**Table of Contents**

- [Signup for AWS](##signup-for-aws)
- [Setup MFA for the Root User](##setup-mfa-for-the-root-user)
- [Create an IAM User](##create-an-iam-user)
- [Generate an SSH Key](##generate-an-ssh-key)
- [Create a Security Group](create-a-security-group)
- [Launch an Instance](##launch-an-instance)
- [Deploy your App](##deploy-your-app)
- [Connect](##connect)

# Deploy your App on AWS

---

## Signup for AWS

The [free tier](https://aws.amazon.com/free/) is free for one year. Remember to stick with RHEL t2.micro instances for this exercise.

Caveat: There are limits 


##Setup MFA for the Root User

Setup MFA for your root account:

Login to the [AWS Console](https://console.aws.amazon.com/) using your Amazon email and password.

Setup MFA: Select your user name > `Security Credentials` > `Multi-Factor Authentication (MFA)` > `Activate MFA`, select `A virtual MFA device` click `Next Step`. Enter in two consecutive MFA codes (1st in `Authentication Code 1` and second in `Authentication Code 2`) and click `Activate Virtual MFA`.

##Create an IAM User

1. Select `Services` > `IAM`. Select `Users` > `Create New Users`. Enter a username on the first field, ensure that `Generate an access key for each user` is selected and click `Create`.

2. Create a group: Select `Groups` > `Create New Group`, enter in `ec2-admin` under `Group Name`. Click `Next Step` > `Next Step` (selecting no policies) > `Create Group`. Select the `ec2-admin` group > `Permissions` > `Inline Policies` > `click here`. Select `Custom Policy` then click `Select`.

 Set `IAMSelfManage` as the `Policy Name` and the following JSON document for the `Policy Document`.

 ```
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:ChangePassword",
                "iam:CreateAccessKey",
                "iam:DeleteAccessKey",
                "iam:UpdateAccessKey",
                "iam:ListAccessKeys",
                "iam:DeactivateMFADevice",
                "iam:ListMFADevices",
                "iam:EnableMFADevice",
                "iam:ResyncMFADevice",
                "iam:DeactivateMFADevice",
                "iam:DeleteVirtualMFADevice",
                "iam:ListVirtualMFADevice",
                "iam:CreateVirtualMFADevice",
                "iam:ListGroupsForUser",
                "iam:ListSigningCertificates",
                "iam:ListUserPolicies",
                "iam:GetLoginProfile"
            ],
            "Resource": [
                "arn:aws:iam:::mfa/${aws:username}",
                "arn:aws:iam:::user/${aws:username}"
            ]
        },
        {
            "Sid": "AllowUsersToListVirtualMFADevices",
            "Effect": "Allow",
            "Action": [
                "iam:ListUsers",
                "iam:ListVirtualMFADevices"
            ],
            "Resource": [
                "arn:aws:iam:::mfa/*",
                "arn:aws:iam:::user/*"
            ]
        }
    ]
}
 ```

 Select `Create Group Policy`, select `Custom Policy` > `Select`. Set `EC2Admin` as the `Policy Name` and the following JSON document for the `Policy Document`.
 
 ```
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
 ```

 Now, assign the new group to your new IAM user.
 
3. Setup MFA for your new IAM user. Select `Users`, select your user name, select `Security Credentials` > `Manage MFA Device`. Select `A virtual MFA device` click `Next Step`. Enter in two consecutive MFA codes (1st in `Authentication Code 1` and second in `Authentication Code 2`) and click `Activate Virtual MFA`.


**Question:** What is the difference between the root user and an IAM user?

##Generate an SSH Key

On the AWS Console, select `Services` > `EC2`, make sure you are using the Oregon region, you can do this by selecting the region from the upper right section of the console. Select `Key Pairs` > `Create Key Pair`. Enter in your IAM username for the `Key pair name` and click `Create`. Save the file to a secure location.

##Create a Security Group

Select `Security Groups` from the AWS Console. Click `Create Security Group`, enter `bootcamp-web-ports` for `Security group name` and `Web Ports for App` for `Description`. Under security group rules, click `Add Rule` and add a rule for SSH and another for HTTP. Under source, select `My IP`.

Note: never use `0.0.0.0/0` or `Anywhere` for the source setting.

##Launch an Instance

Using the AWS Web Console launch a t1.micro RHEL instance. Use the Oregon region (us-west-2), you can do this by selecting the region from the upper right section of the console. 

From the AWS Console, select `Services` > `EC2`. Click `Launch Instance`. Select `Red Hat Enterprise Linux 7.2 (HVM)`, select `t2.micro` > click `Next: Configure Instance Details` > `Next: Add Storage` > `Next: Tag Instance` (tag it with a fancy name) > `Next: Configure Security Group`. Select existing security group, choose the security group you created above. Click Review and Launch, click Launch, select the key pair you created above and click `Launch Instance`.

##Deploy your App

SSH into AWS host:

```
$ ls -l ~/Downloads/jg.pem
$ chmod 600 ~/Downloads/jg.pem
$ ssh -i ~/Downloads/jg.pem ec2-user@54.x.x.x
$ sudo yum -y install git
$ sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
```

Install Ruby:

```
$ cd
$ git clone git://github.com/sstephenson/rbenv.git .rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

$ git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
$ echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile

$ source ~/.bash_profile
```

Install dependencies:

```
$ sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
$ sudo yum -y install nodejs
$ sudo yum -y install mariadb mariadb-server mariadb-devel
$ sudo systemctl start mariadb.service
```

Install Ruby:

```
$ rbenv install -v 2.3.1
$ rbenv global 2.3.1
$ ruby -v
$ gem install bundler --no-ri --no-rdoc
$ gem install rails --no-ri --no-rdoc

```

Install and run app:

```
$ git clone https://github.com/godinezj/myapp.git
$ cd myapp
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rails server -b 0.0.0.0
```

On your browser open [http://54.x.x.x:3000/](http://54.x.x.x:3000/). 

Can you connect? If not, why not? You may need to open TCP port 3000.

##Clean Up

1. Turn off your instance
2. Protect your credentials
3. Never open up security groups to the world




