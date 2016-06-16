#!/usr/bin/env ruby

require 'json'
require 'cgi'
require 'net/http'

issuer_url = 'gui.rb'
console_url = 'https://console.aws.amazon.com/'
signin_url = 'https://signin.aws.amazon.com/federation'

session_json = { sessionId: ENV['AWS_ACCESS_KEY_ID'],
                 sessionKey: ENV['AWS_SECRET_ACCESS_KEY'],
                 sessionToken: ENV['AWS_SESSION_TOKEN'] }.to_json
get_signin_token_url = signin_url + '?Action=getSigninToken' + '&SessionType=json&Session=' + CGI.escape(session_json)
returned_content = Net::HTTP.get(URI.parse(get_signin_token_url))

signin_token = JSON.parse(returned_content)['SigninToken']
signin_token_param = '&SigninToken=' + CGI.escape(signin_token)

issuer_param = '&Issuer=' + CGI.escape(issuer_url)
destination_param = '&Destination=' + CGI.escape(console_url)
login_url = signin_url + '?Action=login' + signin_token_param + issuer_param + destination_param

puts "\n\nCopy and paste this URL into your browser:\n#{login_url}"
