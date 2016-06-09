# Lab 1

**Table of Contents**

- [Setup MFA for your IAM User](##setup-mfa-for-your-iam-user)
- [Assume Deployment Admin in Target Account](##assume-deployment-admin-in-target-account)
- [Automate Role Assumption](##automate-role-assumption)

# Control Plane Basics

---

## Setup MFA for your IAM User

1. Log into AWS. Change your password when prompted.

 AWS Console URL: [https://ldcp-iis-my-ctrl-app-lrn.signin.aws.amazon.com/console](https://ldcp-iis-my-ctrl-app-lrn.signin.aws.amazon.com/console)

 Passwords must have:

 - 11 characters
 - Mixed case letters
 - At least 1 number
 - At least 1 special character

2. Setup MFA for your new IAM user: select `Services` > `IAM`, select `Users`, select your user name, select `Security Credentials` > `Manage MFA Device`. Select `A virtual MFA device` click `Next Step`. Enter in two consecutive MFA codes (1st in `Authentication Code 1` and second in `Authentication Code 2`) and click `Activate Virtual MFA`.

## Generate API Access Keys

Generate API access keys and configure them into your AWS CLI.

1. Under your user's `Security Credentials` click `Create Access Keys` > `Download Credentials` (save the file) > `Close`.

2. On your command line, use `aws configure` to configure the credentials you just downloaded.

 E.g.,
 ```
$ aws configure --profile dso
AWS Access Key ID [None]: AKIA...
AWS Secret Access Key [None]: ...
Default region name [None]: us-west-2
Default output format [None]: json
 ```

## Assume a Role in Target Account

Use AWS STS to assume the role of DeploymentAdmin (DA) into the target account.

First set your AWS_USERNAME environment variable.

```
echo "export AWS_USERNAME=INSERT_YOUR_USERNAME_HERE" >> ~/.bash_profile
source ~/.bash_profile
```

1. Use STS to assume the control account role. This command will return JSON formatted text which contains credential to be used in the next step.

 ```
aws sts assume-role \
--role-arn arn:aws:iam::100352119871:role/dso/ctrl/my-app/CTL-my-app-DeploymentAdmin \
--role-session-name $AWS_USERNAME-$$ --profile dso \
--serial-number arn:aws:iam::100352119871:mfa/$AWS_USERNAME \
--token-code 123456
 ```

2. Export control STS credentials.

 ```
$ export AWS_ACCESS_KEY_ID=ASI...
$ export AWS_SECRET_ACCESS_KEY=...
$ export AWS_SESSION_TOKEN=...
 ```

3. Use AWS STS to assume the target account role (DeploymentAdmin).

 ```
aws sts assume-role \
--role-arn arn:aws:iam::717986480831:role/human/dso/TGT-dso-DeploymentAdmin \
--role-session-name $AWS_USERNAME-$$
 ```

 2. Export target STS credentials.

  ```
 $ export AWS_ACCESS_KEY_ID=ASI...
 $ export AWS_SECRET_ACCESS_KEY=...
 $ export AWS_SESSION_TOKEN=...
  ```

5. Open AWS console with temporary credentials.

 You can use the following ruby script (`console.rb`) to do this:

  ```
  require 'json'
  require 'cgi'
  require 'net/http'

  issuer_url = 'gui.rb'
  console_url = 'https://console.aws.amazon.com/'
  signin_url = 'https://signin.aws.amazon.com/federation'

  session_json = { sessionId: ENV['AWS_ACCESS_KEY_ID'],
                   sessionKey: ENV['AWS_SECRET_ACCESS_KEY'],
                   sessionToken: ENV['AWS_SESSION_TOKEN'] }.to_json
  get_signin_token_url = signin_url + '?Action=getSigninToken' + '&SessionType=json&Session=' + CGI.escape(session_json)
  returned_content = Net::HTTP.get(URI.parse(get_signin_token_url))

  signin_token = JSON.parse(returned_content)['SigninToken']
  signin_token_param = '&SigninToken=' + CGI.escape(signin_token)

  issuer_param = '&Issuer=' + CGI.escape(issuer_url)
  destination_param = '&Destination=' + CGI.escape(console_url)
  login_url = signin_url + '?Action=login' + signin_token_param + issuer_param + destination_param

  puts "\n\nCopy and paste this URL into your browser:\n#{login_url}"
   ```
