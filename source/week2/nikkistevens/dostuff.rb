#!/usr/bin/env ruby

require 'assumer'

# First Jump
control_creds = Assumer::Assumer.new(
  region: aws_region,
  account: control_plane_account_number,
  role: control_plane_role,
  serial_number: serial_number, # if you are using MFA, this will be the ARN for the device
  profile: credential_profile_name # if you don't want to use environment variables or the default credentials in your ~/.aws/credentials file
)
# Second jump
target_creds = Assumer::Assumer.new(
  region: aws_region,
  account: target_plane_account_number,
  role: target_account_role,
  credentials: control_creds
)
