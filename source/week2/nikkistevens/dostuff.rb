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

#ec2 stuff
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
  #print dat  bucket name
  puts b.name
  # this is going to error on my second bucket because of the period in the name and the acceleration.
   response2 = s3.list_objects_v2({
     bucket: b.name,
     max_keys: 10,
    use_accelerate_endpoint: true
   })
  # each item in dat bucket
  response2.contents.each do |c|
    puts c.key
  end


end

# show an arbirarily-limited list of 10 things inside each buckets
# http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Client.html#list_objects-instance_method





# # First Jump
# control_creds = Assumer::Assumer.new(
#   region: aws_region,
#   account: control_plane_account_number,
#   role: control_plane_role,
#   serial_number: serial_number, # if you are using MFA, this will be the ARN for the device
#   profile: credential_profile_name # if you don't want to use environment variables or the default credentials in your ~/.aws/credentials file
# )
# # Second jump
# target_creds = Assumer::Assumer.new(
#   region: aws_region,
#   account: target_plane_account_number,
#   role: target_account_role,
#   credentials: control_creds
# )
