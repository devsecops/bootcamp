#!/bin/bash
# godinezj@gmail.com
# Creates an AWS IAM admin user. This script can be used to elevate privileges
# from an AWS host with an instance profile or Access Keys with the following
# privileges:
#  - iam:CreateUser
#  - iam:CreateUser
#  - iam:AddUserToGroup
#  - iam:CreateAccessKey

# debug, so you can see the commands run on your console
set -ex

export USERNAME=$1
export GROUPNAME=$1
export POLICYNAME=$1

if [[ -z "$USERNAME" ]]; then
  echo "Please provide a name"
  exit 1
fi

# create user and group
aws iam create-user --user-name $USERNAME
aws iam create-group --group-name $USERNAME

# adds the policy ($POLICY) to the group
aws iam put-group-policy --group-name $GROUPNAME --policy-name $POLICYNAME \
  --policy-document '{"Version": "2012-10-17", "Statement": [{"Sid": "Stmt1437414476731", "Action": "*","Effect": "Allow", "Resource": "*" }]}'

# adds the user to the group
aws iam add-user-to-group --group-name $GROUPNAME --user-name $USERNAME

# create access keys, make sure to keep the output of this command secret
aws iam create-access-key --user-name $USERNAME
