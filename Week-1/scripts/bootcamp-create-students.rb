#############################################
# DevSecOps Bootcamp - user creation script #
#############################################
#
# Usage: ruby bootcamp-create-students > creds.csv

require 'aws-sdk'
require 'securerandom'

def create_users()
  iam = Aws::IAM::Client.new(region: "us-west-2") # required
puts "username,password"
  (1..31).each do |i|
    resp = iam.create_user(user_name: "student#{i}") # required

    resp = iam.add_user_to_group({
      group_name: "student", # required
      user_name: "student#{i}", # required
    })

  password = SecureRandom.base64[0..13]
    resp = iam.create_login_profile({
      user_name: "student#{i}", # required
      password: "#{password}!", # required
      password_reset_required: true,
    })
  puts "student#{i},#{password}!"
  end
end

create_users()
