# Lab 1

**Table of Contents**

- [Top-Level Structure](##top-level-structure)
- [Parameters](##parameters)
- [Resources](##resources)
- [UserData](##userdata)
- [Launch your Stack](##launch-your-stack)
- [Outputs](##outputs)

# CloudFormation Basics

On this lab we will convert our infrastructure into code by using CloudFormation to stand up the same stack from last week.

*Resources:*

- [http://jsonlint.com/](http://jsonlint.com/)
- [http://www.tutorialspoint.com/json/json_data_types.htm](http://www.tutorialspoint.com/json/json_data_types.htm)
- [http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/parameters-section-structure.html](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/parameters-section-structure.html)
- [http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/outputs-section-structure.html](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/outputs-section-structure.html)

---

## Top-Level Structure

Create a CloudFormation template.

CloudFormation makes use of JSON to define parameters, resources and outputs. The high-level CloudFormation data structure is an Object; in JSON, Object are associative-arrays, i.e., a JSON Object associates keys with values.

1. Create a new plain-text JSON file with the following sections. These are the minimum requirements for defining a CloudFormation template.

  * `AWSTemplateFormatVersion`
  * `Parameters`
  * `Resources`
  * `Outputs`

2. Name it `<STUDENT ID>_lab_1.json` and save it to your desktop.

It should look something like:

```
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Description": "...",
  "Parameters": {

  },
  "Resources": {

  },
  "Outputs": {

  }
}
```

## Parameters

Parameters in CloudFormation are also JSON arrays, these take a `Type` and a `Description`. Fill in the parameters section to your CloudFormation template.

1. Fill in the parameters section with `StudentId`, `KeyName`, `SubnetId`, `InstanceType`, `AmiId`, and `WebAppSecurityGroup`.

It should look something like:

```
  "StudentId": {
    "Type": "String",
    "Description": "Your student id, e.g., student1"
  },
  "KeyName": {
    "Type": "AWS::EC2::KeyPair::KeyName",
    "Description": "Name of an existing EC2 KeyPair to enable SSH access to the instance"
  },
  "SubnetId": {
    "Type": "AWS::EC2::Subnet::Id",
    "Description": "A subnet ID where the app will run"
  },
  "VpcId": {
    "Type": "AWS::EC2::VPC::Id",
    "Description": "A VPC ID where the app will run"
  },
  "InstanceType": {
    "Description": "WebServer EC2 instance type",
    "Type": "String",
    "Default": "m3.medium"
  },
  "AmiId": {
    "Description": "The AMI (Amazon Machine Image) ID",
    "Type": "AWS::EC2::Image::Id"
  },
  "WebAppSecurityGroup": {
    "Description": "The Web application security group ID",
    "Type": "AWS::EC2::SecurityGroup::Id"
  }
```

## Resources

Within the `Resources` section define a resource named `WebServerInstance` of type `AWS::EC2::Instance`. `AWS::EC2::Instance` requires `Properties`, `ImageId`, `InstanceType`, and `KeyName` sections. Note how parameters are passed from the `Parameters` section to the definition of the resource.


It should look something like:

```
"WebServerInstance": {
  "Type": "AWS::EC2::Instance",
  "Properties": {
    "NetworkInterfaces": [
      {
        "AssociatePublicIpAddress": "true",
        "DeviceIndex": "0",
        "GroupSet": [
          {
            "Ref": "WebAppSecurityGroup"
          }
        ],
        "SubnetId": {
          "Ref": "SubnetId"
        }
      }
    ],
    "ImageId": {
      "Ref": "AmiId"
    },
    "InstanceType": {
      "Ref": "InstanceType"
    },
    "KeyName": {
      "Ref": "KeyName"
    },
    "Tags": [
      {
        "Key": "Name",
        "Value": {
          "Ref": "StudentId"
        }
      }
    ]
  }
}
```

## UserData

Add a `UserData` section to the `Properties` subsection of the `WebServerInstance` resource. In the UserData section, embed the necessary commands to install your application.


It should look something like:

```
"UserData": {
  "Fn::Base64": {
    "Fn::Join": [
      "",
      [
        "#!/bin/bash -xe\n",
        "rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-7.noarch.rpm\n",
        "yum -y install git git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel\n",
        "yum -y install nodejs mariadb mariadb-server mariadb-devel\n",
        "systemctl enable mariadb.service\n",
        "systemctl start mariadb.service\n",
        "rpm -ivh https://s3-us-west-2.amazonaws.com/dso-public-bucket/ruby-2.3.1-1.el7.x86_64.rpm\n",
        "cd /home/ec2-user\n",
        "echo \"export GEM_HOME=~/.gem\" >> .bash_profile\n",
        "echo \"export GEM_PATH=~/.gem\" >> .bash_profile\n",
        "echo \"export RAILS_ENV=mysql\" >> .bash_profile\n",
        "echo \"export PATH=~/.gem/bin:$PATH\" >> .bash_profile\n",
        "su -l -c \"git clone https://github.com/OWASP/railsgoat.git\" ec2-user\n",
        "su -l -c \"gem install bundler\" ec2-user\n",
        "su -l -c \"cd railsgoat && bundle install && bundle exec rake db:setup\" ec2-user\n",
        "su -l -c \"cd railsgoat && bundle exec rails server -b 0.0.0.0 -p 8080 &\" ec2-user\n",
        "\n"
      ]
    ]
  }
}
```

** The resulting template should look something like [lab-1.json](../scripts/lab-1.json).

## Launch your stack

1. Log into the DSO target account.

  E.g.,

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 717986480831 -r human/dso/TGT-dso-DeploymentAdmin \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-DeploymentAdmin \
    -o dso -g -u $AWS_USERNAME
  ```

2. Take note of your instance's configuration you will need these fields:

  * Subnet ID
  * VPC ID
  * AMI ID
  * Security Group ID
  * Key Pair (your key name)

3. **Terminate** your (hand-jammed) instance. You can do this by selecting it in the console, then selecting `Actions` > `Instance State` > `Terminate`.

4. Using the resources at the top of this lab, verify your CloudFormation template by validating the JSON file.

5. On the AWS Console select `Services` > `CloudFormation`. Then click `Create Stack`, select `Upload a template to Amazon S3`, click `Browse...` and select your CloudFormation template and click `OK`. Click `Next`.

6. Enter your student ID under `Stack name`. Using the information collected from step 2, fill in the rest of the form fields. Click `Next`, click `Next`, click `Create`. Wait until your stack deployment is successful (`CREATE_COMPLETE`). If you get a `ROLLBACK_COMPLETE` error, look under the `events` tab in the CloudFormation console to determine what's going on.

7. Go back to `EC2`, note the public IP address of your new instance, once `Status Checks` pass, ssh into the instance. Keep an eye on `/var/log/cloud-init.log` to see if any errors occur. You can do this with `tail`, e.g., `tail -f /var/log/cloud-init.log`, to exit `tail` press `ctrl+c`.

8. Load `http://PUBLIC_IP_ADDRESS:8080` on your browser. Is your application up and running?
## Outputs

**Challenge:** Using your awesome skills and the resources above fill in the Outputs section to expose/print your application's URL. Destroy your stack, make the changes and reload it. Under the Outputs tab in the CloudFormation console, make sure that your application URL is displayed.
