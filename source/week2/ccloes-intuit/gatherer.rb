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
  banner 'Usage: slop_test.rb [options]'
  on :b, :bucket, 'get s3 bucket resources'
  on :e, :ec2, 'get ec2 resources'
  on :r, :region=, 'aws region resources are in', optional: false
  on :a, :account=, 'control plane account number', optional: false
  on :t, :target=, 'target aws account number', optional: false
  on :C, :controlrole=, 'control plane role', optional: false
  on :T, :targetrole=, 'target account role', optional: false
  on :s, :serial=, 'serial number of mfa', optional: false
  on :p, :profile=, 'aws cli profile name', optional: false
end

opts.parse

if opts.bucket?
  creds = get_creds(opts[:region], opts[:account], opts[:controlrole], opts[:serial], opts[:profile], opts[:target], opts[:targetrole])
  s3 = Aws::S3::Client.new(region: opts[:region], credentials: creds.assume_role_credentials)
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
  creds = get_creds(opts[:region], opts[:account], opts[:controlrole], opts[:serial], opts[:profile], opts[:target], opts[:targetrole])
  ec2 = Aws::EC2::Client.new(region: opts[:region], credentials: creds.assume_role_credentials)
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


