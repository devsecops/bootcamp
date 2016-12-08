#!/usr/bin/env ruby

require 'aws-sdk'
require 'json'

# NOTE: This script assumes a profile ('dso') set up similarly to Week 3/Lab 1
# NOTE: This script assumes an appropriate username exported in the .bash_profile
# NOTE: This script assumes a valid MFA token as the first command line argument

$debug = 0

$access_key = ""
$secret_key = ""
$session_token = ""

# a method to clear AWS environment variables
def aws_unset
  ENV["AWS_ACCESS_KEY_ID"] = ""
  ENV["AWS_SECRET_ACCESS_KEY"] = ""
  ENV["AWS_SESSION_TOKEN"] = ""
  puts "Keys cleared." if $debug == 1
end

# a method to parse Session JSON data
def parse_session(json)
  data = JSON.parse(json)
  credentials = data["Credentials"]
  $access_key = credentials["AccessKeyId"]
  $secret_key = credentials["SecretAccessKey"]
  $session_token = credentials["SessionToken"]
end

# a method to set AWS environment variables
def aws_set
  ENV["AWS_ACCESS_KEY_ID"] = $access_key
  ENV["AWS_SECRET_ACCESS_KEY"] = $secret_key
  ENV["AWS_SESSION_TOKEN"] = $session_token
  puts "Keys set." if $debug == 1
end

# clear AWS environment vars
aws_unset

# get the MFA token from the command line
if ARGV.size == 0
  puts "Please provide a valid MFA token associated with this AWS account."
  puts "USAGE: ruby auto-assume.rb <MFA-TOKEN>"
  abort
else
  mfa_token = ARGV[0]
end

# call sts to get temp credentials, parse the JSON, and set the env vars
sts_json = %x(aws sts assume-role --role-arn arn:aws:iam::100352119871:role/dso/ctrl/my-app/CTL-my-app-DeploymentAdmin --role-session-name $AWS_USERNAME-$$ --profile dso --serial-number arn:aws:iam::100352119871:mfa/$AWS_USERNAME --token-code #{mfa_token})
parse_session(sts_json)
aws_set

# call sts to assume the DeploymentAdmin role, parse the JSON, clear and then set the env vars
admin_json = %x(aws sts assume-role --role-arn arn:aws:iam::717986480831:role/human/dso/TGT-dso-DeploymentAdmin --role-session-name $AWS_USERNAME-$$)
parse_session(admin_json)
aws_unset
aws_set

# call console.rb, put the text out to the command line
puts %x{ruby console.rb}
