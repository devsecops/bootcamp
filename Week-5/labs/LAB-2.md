# Lab 2

**Table of Contents**

- [Setup](##setup)
- [Add Auto Scaling](##add-auto-scaling)
- [Add a Launch Configuration](##add-a-launch-configuration)
- [Update UserData](##update-userdata)
- [Add an Elastic Load Balancer](##add-an-elastic-load-balancer)
- [Launch your Stack](##launch-your-stack)

# Application availability and CloudFormation

On this lab we will use AWS CloudFormation to stand up a resilient stack.

---

## Setup

Create two new security groups and update the CloudFormation template parameters to support tiered infrastructure.

1. Create a new security group named `<STUDENT ID>-app`. This security group should allow connections from `10.0.0.0/21` to TCP ports `8080` and `22`. Note the security group ID.

2. Create a new security group named `<STUDENT ID>-elb`. This security group should allow connection from your IP address to TCP port `80`. Note the security group ID.

3. Copy the CloudFormation template into a new file named `<STUDENT ID>_lab_2.json`.

4. Update the CloudFormation template adding an ELB subnet parameter.

  Change the `SubnetId` parameter name to `AppSubnetId` and create a new parameter named `ElbSubnetId` of type `AWS::EC2::Subnet::Id`.

5. Update the CloudFormation template adding an ELB security group parameter.

  Create a new parameter named `ElbSecurityGroups` of type `AWS::EC2::SecurityGroup::Id`.

## Add Auto Scaling

Create a new resource named `ScalingGroup` of type `AWS::AutoScaling::AutoScalingGroup`.


It should look something like:

```
"ScalingGroup": {
  "Type": "AWS::AutoScaling::AutoScalingGroup",
  "Properties": {
    "VPCZoneIdentifier": [
      {
        "Ref": "AppSubnetId"
      }
    ],
    "LaunchConfigurationName": {
      "Ref": "WebServerInstance"
    },
    "LoadBalancerNames": [
      {
        "Ref": "StudentId"
      }
    ],
    "MinSize": "1",
    "DesiredCapacity": "1",
    "MaxSize": "1",
    "Tags": [
      {
        "Key": "Name",
        "Value": {
          "Ref": "StudentId"
        },
        "PropagateAtLaunch": "true"
      }
    ]
  }
}
```

## Add a Launch Configuration

1. Change the `WebServerInstance` type from an `AWS::EC2::Instance` to an `AWS::AutoScaling::LaunchConfiguration`.

2. Remove the `NetworkInterfaces` and `Tags` subsections from the `WebServerInstance` resource.

3. Add a `SecurityGroups` subsection to the `WebServerInstance` resource. `SecurityGroups` should take an array of security group IDS.

It should look something like:

```
"WebServerInstance": {
  "Type": "AWS::AutoScaling::LaunchConfiguration",
  "Properties": {
    "SecurityGroups": [
      {
        "Ref": "AppSecurityGroup"
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
    "UserData": {
      ...
    }
  }
}
```

## Update UserData

Update the `WebServerInstance` `UserData` subsection to add proxy support.

1. Export `http_proxy` and `https_proxy` environment variables so that calls to Yum repositories can be proxied.

  At the top of the UserData section (second line) add `export http_proxy=http://proxy:3128` do the same for `http_proxy`.

2. Make the necessary changes to ensure that these environment variables are loaded when you log in.

It should look something like:

```
"Fn::Base64": {
  "Fn::Join": [
    "",
    [
      "#!/bin/bash -xe\n",
      "export http_proxy=http://proxy:3128\n",
      "export https_proxy=http://proxy:3128\n",
      "rpm -ivh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-7.noarch.rpm\n",
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
      "echo \"export http_proxy=http://proxy:3128\" >> .bash_profile\n",
      "echo \"export https_proxy=http://proxy:3128\" >> .bash_profile\n",
      "echo \"export no_proxy=localhost,127.0.0.1,254.169.254.169\" >> .bash_profile\n",
      "echo \"[http]\n    proxy = $http_proxy\" >> .gitconfig\n",
      "chown ec2-user: .gitconfig\n",
      "su -l -c \"git clone https://github.com/OWASP/railsgoat.git\" ec2-user\n",
      "su -l -c \"gem install bundler\" ec2-user\n",
      "su -l -c \"cd railsgoat && bundle install && bundle exec rake db:setup\" ec2-user\n",
      "su -l -c \"cd railsgoat && bundle exec rails server -b 0.0.0.0 -p 8080 &\" ec2-user\n",
      "\n"
    ]
  ]
}
```

## Add an Elastic Load Balancer

Add an Elastic Load Balancer (ELB) resource to the CloudFormation template.


It should look something like:

```
"ServiceLoadBalancer": {
  "Type": "AWS::ElasticLoadBalancing::LoadBalancer",
  "Properties": {
    "LoadBalancerName": {
      "Ref": "StudentId"
    },
    "CrossZone": "true",
    "HealthCheck": {
      "HealthyThreshold": "3",
      "Interval": "30",
      "Target": "TCP:8080",
      "Timeout": "5",
      "UnhealthyThreshold": "5"
    },
    "Listeners": [
      {
        "InstancePort": "8080",
        "InstanceProtocol": "TCP",
        "LoadBalancerPort": "80",
        "Protocol": "TCP"
      }
    ],
    "Scheme": "internet-facing",
    "SecurityGroups": [{
      "Ref": "ElbSecurityGroups"
    }],
    "Subnets": [
      {
        "Ref": "ElbSubnetId"
      }
    ],
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

## Launch your Stack

1. Log into the DSO target account.

  E.g.,

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 717986480831 -r human/dso/TGT-dso-DeploymentAdmin \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-DeploymentAdmin \
    -o dso -g -u $AWS_USERNAME
  ```

2. Take note of your instance's configuration and new security groups you created. Also make note of a private subnet (`AppSubnetId`) and a public subnet (`ElbSubnetId`) where your instance and ELBs will run (respectively). **IMPORTANT:** Ensure that the `AppSubnetId` and `ElbSubnetId` are in the same Availability Zone.

3. **Terminate** your stack from Lab 1. You can do this by selecting it in the CloudFormation console, then selecting `Actions` > `Delete Stack`.

4. Using the resources at the top of this lab, verify your CloudFormation template by validating the JSON file.

5. On the AWS Console select `Services` > `CloudFormation`. Then click `Create Stack`, select `Upload a template to Amazon S3`, click `Browse...` and select your CloudFormation template and click `OK`. Click `Next`.

6. Enter your student ID under `Stack name`. Using the information collected from step 2, fill in the rest of the form fields. Click `Next`, click `Next`, click `Create`.

7. Go back to `EC2`, look up your new instance, note the **private** IP address and ssh into the bastion and then onto your instance. Keep an eye on `/var/log/cloud-init.log` to see if any errors occur. You can do this with `tail`, e.g., `tail -f /var/log/cloud-init.log`, to exit `tail` press `ctrl+c`.

8. Load `http://ELB_DNS_NAME` on your browser. Is your application up and running?

** The resulting template should look something like [lab-2.json](../scripts/lab-1.json).
