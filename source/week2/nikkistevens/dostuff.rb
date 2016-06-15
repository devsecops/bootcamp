#!/usr/bin/env ruby
require 'rubygems'

require 'pp'
require 'aws-sdk'
require 'json'
creds = JSON.load(File.read('secrets.json'))
# put region in secrets.
Aws.config.update({
  region: 'us-east-1',
  credentials:  Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])
});

ec2 = Aws::EC2::Client.new()

# describe instances
# http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Client.html#describe_instances-instance_method
response = ec2.describe_instances({
  max_results: 10
})

puts response.reservations
response.reservations.each do |res|
  # i will nest loops in every language.
  res.instances.each do |i|
    puts 'instance id ' + i.instance_id
    puts 'tenancy ' + i.placement.tenancy
    puts  'security groups ' + i.security_groups.to_s
    puts 'image id ' + i.image_id
    puts 'launch time ' + i.launch_time.to_s
  # Each EC2 instance, find out its InstanceRole
  end
end

# print all of the s3 buckets.
s3 = Aws::S3::Client.new
response = s3.list_buckets()

response.buckets.each do |b|
  # print dat  bucket name
  puts b.name
  # this is going to error on my second bucket.
   response2 = s3.list_objects_v2({
     bucket: b.name,
     max_keys: 10,
     use_accelerate_endpoint: true
   })
  # print each item in dat bucket
  response2.contents.each do |c|
    puts c.key
  end
end
