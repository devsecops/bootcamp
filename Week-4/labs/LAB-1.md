# Lab 1

**Table of Contents**

- [Run Rails Goat](##run-rails-goat)
- [Intro to the Splunk Console](##intro-to-the-splunk-console)
- [Splunk Search](##splunk-search)

# Splunk Introduction

In this lab we will be relaunching our vulnerable application and running basic Splunk queries to familiarize ourselves with logging data.

---

## Run Rails Goat

1. Use [assumer](https://github.com/devsecops/assumer) to log into the target account. Make sure AWS_USERNAME is set to your student ID.

 E.g.,

 ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 717986480831 -r human/dso/TGT-dso-DeploymentAdmin \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-DeploymentAdmin \
    -o dso -g -u $AWS_USERNAME
 ```

2. Lookup the public IP address for your instance under EC2, then SSH into your instance, start Splunk and MariaDB and run rails goat.

 ```
$ ssh -i student1.pem ec2-user@54.x.x.x
$ sudo /opt/splunkforwarder/bin/splunk start
$ sudo systemctl start mariadb.service
$ cd ~/railsgoat
$ export RAILS_ENV=mysql
$ bundle exec rake db:setup
$ bundle exec rails server -b 0.0.0.0 -p 8080
 ```

## Intro to the Splunk Console

1. Login to Splunk by opening the Splunk Console with your browser. The instructor will provide credentials for you.

Splunk Console: [https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F](https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F)

2. Change your password by clicking your username in the upper-right navigation pane, then clicking `Edit Account`. Fill out the `Password` and `Confirm password` fields, click `Save`.

3. Click `Search & Reporting` and take the tour when prompted.

## Splunk Search

1. Under the Search & Reporting app, select the search input box, enter `index=main` and adjust the timeframe to `Last 15 minutes` by clicking the pull down to the right of the search input box. `Last 15 minutes` should appear under `Presets`. Click the search magnifying glass or hit `Enter`.

 How many events you get?

2. Adjust the time to `all time`, how many events you get?

3. Find your host logs. First lookup your instance's DNS name in the AWS console by selecting your instance (denoted by your username). Note the `Private DNS`  (e.g., `ip-10.0.0.4.us-west-2.compute.internal`). Then enter `index=main host=<Private DNS>` in the search input box, e.g., `index=main host=ip-10.0.0.4.us-west-2.internal`.

4. Familiarize your self with the `source` and `sourcetype` fields on the left pane. Also take a look at the `Interesting Fields`.

## Splunk Tours

1. Click `Dashboards`, take the tour when prompted.
2. Click `Alerts`, take the tour when prompted.
3. Click `Reports`, take the tour when prompted.
