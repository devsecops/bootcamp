#!/usr/bin/env ruby
require 'assumer'
require 'aws-sdk'

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


s3 = Aws::S3::Client.new(region: "us-west-2", credentials: target_creds.assume_role_credentials)
resp = s3.list_buckets
resp.buckets.each do |b|
  puts b.name
  objects = s3.list_objects(bucket: b.name)
  objects.contents.each do |o|
    puts " - " + o.key
  end
end

ec2 = Aws::EC2::Client.new(region: "us-west-2", credentials: target_creds.assume_role_credentials)
resp = ec2.describe_instances
resp.reservations.each do |e|
  e.instances.each do |i|
    puts "ID: " + i.instance_id
    puts " TENANCY: " + i.placement.tenancy
    puts " AMI: " + i.image_id
    puts " LAUNCH: " + i.launch_time.to_s
    print " SGROUPS: "
    i.security_groups.each do |s|
      print s.group_id
    end
    puts "\n"
  end
end
