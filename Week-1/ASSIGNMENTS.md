# WEEK 1 ASSIGNMENTS

Note: All assignments should be made as a pull request to the upstream (i.e. `devsecops`) `Bootcamp-Labs` repository, with branch name: `week1-$USERNAME`

## Assignment \#1: Add an item in FAQ.md
Add an item to the FAQ.md

## Assignment \#2: Sign up for AWS Free Tier
We will be using Amazon Web Services (AWS) for some of our upcoming labs. In order to get a head start please sign up for an AWS Free Tier Account (Credit Card Needed) on your own. The VM you made with Vagrant already has AWS CLI installed in it so you need an account to be able to use it. Directions on how to sign up can be found here:

https://aws.amazon.com/free/

To test out your new AWS Free Tier Account please follow these instructions to log in and create your AWS access keys:

http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html

Once your keys are generated you can use this guide to configure your VM's AWS Cli to talk to your new account:

http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

Your AWS CLI should now be able to connect to the AWS API. Verify this by running:

```
aws ec2 describe-instances --output table --region us-west-2
```
It should return back an empty table. If you got an error then go back through step 2 and three to make sure you have configured the AWS CLI properly.

-----
PS: Your pull request should include:

1. Changes to FAQ.md
