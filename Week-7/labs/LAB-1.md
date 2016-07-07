# Lab 1

**Table of Contents**

- [Gather Instance Data](##gather-instance-configuration)
- [Gather IAM Data](##gather-iam-configuration)
- [Challenge](##challenge)

# Gathering Forensics Configuration

In this lab you will be using the AWS CLI to gather data from your account. Data gathering in the wake of an incident is key to being able to reconstruct the source of the incident. In addition gathering the data will help with being able to reconstruct your application in the new Distaster Recovery (DR) account.

*Resources:*

- [ec2 Command Line Tools] (http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/command-reference.html)
- [ec2-describe-instances](http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-DescribeInstances.html)

# Gathering Instance Configuration

Retrieve current configuration information using the AWS CLI,


1. Log into the DSO target account.

  E.g.,

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 717986480831 -r human/dso/TGT-dso-DeploymentAdmin \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-DeploymentAdmin \
    -o dso -g -u $AWS_USERNAME
  ```

2. Load the the AWS credentials into your environment.

  E.g.,

  ```
$ source '/var/folders/qv/1bbxpqdd5sg2x_my5ndff76hzc5dgp/T/assumer20160706-68010-x7bx75'
  ```

3. Retrieve instance information.

  ```
$ aws ec2 describe-instances > instances.json
  ```

4. Retrieve load balancer information.

  ```
$ aws elb describe-load-balancers > load-balancers.json
  ```

5. Retrieve security group information.

  ```
$ aws ec2 describe-security-groups > security-groups.json
  ```

6. Retrieve RDS instance information.

  ```
$ aws rds describe-db-instances > db-instances.json
  ```
## Gather IAM Configuration

1. Retrieve IAM User information.

  ```
$ aws iam list-users > list-users.json
  ```

  Did this error out? Why?

  Assume the incident response role in the DSO target account.

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 717986480831 -r human/dso/TGT-dso-IncidentResponse \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-IncidentResponse \
    -o dso -g -u $AWS_USERNAME
  ```

  Load the the AWS credentials into your environment, e.g.,

  ```
$ source '/var/folders/qv/1bbxpqdd5sg2x_my5ndff76hzc5dgp/T/assumer20160706-68743-1tsomsa'
  ```

  Try again.

  ```
$ aws iam list-users > users.json
  ```

8. Retrieve IAM Role information.

  ```
$ aws iam list-roles > roles.json
  ```

## Upload Configuration to S3

1. Assume the incident response role in the forensics account if your session has timed out.

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 439426457924 -r human/dso/TGT-dso-IncidentResponse \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-IncidentResponse \
    -o dso -g -u $AWS_USERNAME
  ```

2. Copy all configuration files into the forensics bucket.

  ```
$ for FILE in `ls *.json`; do
    aws s3 cp $FILE s3://dso-bootcamp-forensics/student1/
  done
  ```

## Challenge

Write a script that:

* gathers all forensic configuration from all regions
* uploads forensic configuration to `dso-bootcamp-forensics` bucket.
