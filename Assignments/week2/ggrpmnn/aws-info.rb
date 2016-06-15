#!/usr/bin/env ruby
require 'aws-sdk'

$region = "us-west-2"
$credentials = Aws::SharedCredentials.new(profile_name: "default")

def get_s3_info
  puts "S3 Bucket Information"
  #create a new S3 client
  s3_client = Aws::S3::Client.new(
    region: $region,
    credentials: $credentials
  )

  #get a list of buckets for the given client
  response = s3_client.list_buckets()
  abort("There are no buckets belonging to the current user.") unless response.buckets.length > 0
  #list each bucket by name
  response.buckets.each do |pail|
    puts "- " + pail.name
    #list the contents of each bucket
    #need an object of Aws::S3::Bucket; the client response returns an object of Aws::S3::Type::Bucket
    bucket = Aws::S3::Bucket.new({
	  name: pail.name,
	  client: s3_client
    })
    bucket.objects.each do |object|
	  puts "  * " + object.key
    end
  end
end

def get_ec2_info
  puts "EC2 Instance Information"
  #create EC2 instance list
  ec2_inst = Aws::EC2::Resource.new(region: $region)
  ec2_inst.instances.each do |inst|
    puts "- " + inst.id + ": " + inst.state.name
    #get launch date
    puts "  * Launch Date: " + inst.launch_time.to_s
    #get tenancy

    #get IAM ID
    iam_prof = inst.iam_instance_profile
    print "  * IAM ID: "
    if iam_prof != nil
      puts iam_prof.id
    else
      puts "NONE"
    end
    #get instance role
    #print "  * Instance Role: "
    #if iam_prof != nil
    #
    #else
    # puts "NONE"
    #end
    #get security group
    print "  * Security Group(s): "
    sec_group = inst.security_groups
    if sec_group != nil
     sec_group.each do |group|
       print group.group_name
     end
     puts ""
    else
     puts "NONE"
    end
  end
end

#get_s3_info
puts ""
get_ec2_info
