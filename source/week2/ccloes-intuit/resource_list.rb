#!/usr/bin/env ruby
require 'assumer'
require 'aws-sdk'
require 'slop'

# First Jump
control_creds = Assumer::Assumer.new(
  region: "us-west-2",
  account: "380482008503",
  role: "arn:aws:iam::380482008503:role/bootcamp/assumer_control",
  serial_number: "arn:aws:iam::380482008503:mfa/ccloes", # if you are using MFA, this will be the ARN for the device
  profile: "personal" # if you don't want to use environment variables or the default credentials in your ~/.aws/credentials file
)
# Second jump
target_creds = Assumer::Assumer.new(
  region: "us-west-2",
  account: "380482008503",
  role: "arn:aws:iam::380482008503:role/bootcamp/assumer_target",
  credentials: control_creds
)

opts = Slop.new(strict: true, help: true) do
  on 'b', 'bucket', 'get s3 bucket resources'
  on 'e', 'ec2', 'get ec2 resources'
end

opts.parse

if opts.bucket?
  s3 = Aws::S3::Client.new(region: "us-west-2", credentials: target_creds.assume_role_credentials)
  resp = s3.list_buckets
  resp.buckets.each do |b|
    puts b.name
    objects = s3.list_objects(bucket: b.name)
    objects.contents.each do |o|
      puts " - " + o.key
    end
  end
end

if opts.ec2?
  ec2 = Aws::EC2::Client.new(region: "us-west-2", credentials: target_creds.assume_role_credentials)
  resp = ec2.describe_instances
  resp.reservations.each do |e|
    e.instances.each do |i|
      puts "ID: " + i.instance_id
      puts "\tTENANCY:  " + i.placement.tenancy
      puts "\tAMI:      " + i.image_id
      puts "\tLAUNCH:   " + i.launch_time.to_s
      print "\tSGROUPS:  "
      i.security_groups.each do |s|
        print s.group_id
      end
      puts ""
      if ! i.iam_instance_profile.nil?
        print "\tROLEARN:  " + i.iam_instance_profile.arn
        puts "\tROLEID:   " + i.iam_instance_profile.id
      else
        puts "\tROLEARN:  None"
      end
    end
  end
end
