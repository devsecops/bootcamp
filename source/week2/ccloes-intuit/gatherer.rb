#!/usr/bin/env ruby

require 'assumer'
require 'aws-sdk'
require 'slop'

def get_creds(region, account, controlrole, serial, profile, target, targetrole)
  # First Jump
  control_creds = Assumer::Assumer.new(
    region: region,
    account: account,
    role: controlrole,
    serial_number: serial,
    profile: profile
  )
  # Second jump
  target_creds = Assumer::Assumer.new(
    region: region,
    account: target,
    role: targetrole,
    credentials: control_creds
  )
  return target_creds
end

opts = Slop.new(strict: true, help: true) do
  banner 'Usage: gatherer.rb [options]'
  on :b, :bucket, 'get s3 bucket resources'
  on :e, :ec2, 'get ec2 resources'
  on :r, :region=, 'aws region resources are in', optional: false
  on :a, :account=, 'control plane account number'
  on :t, :target=, 'target aws account number'
  on :C, :controlrole=, 'control plane role'
  on :T, :targetrole=, 'target account role'
  on :s, :serial=, 'serial number of mfa'
  on :p, :profile=, 'aws cli profile name', optional: false
  on :m, :mfa, 'use the assumer functionality with mfa'
end

opts.parse

if opts.mfa?
  creds = get_creds(opts[:region], opts[:account], opts[:controlrole], opts[:serial], opts[:profile], opts[:target], opts[:targetrole]).assume_role_credentials
else
  creds = Aws::SharedCredentials.new(profile_name: opts[:profile])
end

if opts.bucket?
  s3 = Aws::S3::Client.new(region: opts[:region], credentials: creds)
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
  ec2 = Aws::EC2::Client.new(region: opts[:region], credentials: creds)
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


