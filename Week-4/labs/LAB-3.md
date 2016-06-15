# Lab 3

**Table of Contents**

- [Search for Invalid SSH Login Attempts](##search-for-invalid-ssh-Login-attempts)
- [Create a Dashboard](##create-a-ashboard)
- [Dashboard Challenge](##dashboard-challenge)


# Advanced Splunk Search and Dashboards

In this lab we will be performing more complex searches and building a security dashboard.

---

## Search for Invalid SSH Login Attempts

Create a search query that contains both valid and invalid login attempts.

1. Login to Splunk by opening the Splunk Console with your browser. Splunk Console: [https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F](https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F)

2. Modify the search query from the previous lab to also extract  characters preceding invalid usernames into a field. It should look something like: `index=main host=<Private DNS> sourcetype=linux_secure | rex "(?<ssh_message>Invalid user )(?P<invalid_username>[^ ]+) from (?P<remote_host>.+)" | search ssh_message=*`. Also select `All time` from the time range picket.

3. Count the invalid SSH login attempts. You can use `stats` and `eval` functions to count the number of times `ssh_message` is equal to `"Invalid user "`. Name the resulting column `invalid`. Your new query should looks *something* like: `index=main sourcetype=linux_secure host=ip-10-0-0-0.us-west-2.compute.internal | rex "(?<ssh_message>Invalid user )(?P<ssh_message>[^ ]+) from (?P<remote_host>.+)" | stats count(eval(ssh_message="Invalid user ")) as invalid`

4. In the same search query also count the number of valid SSH logins. You can do this by first extracting `Accepted publickey for ` into the `ssh_message` field, e.g., your regular expression (which is passed to rex) could look something like `"(?<ssh_message>Accepted publickey for |Invalid user )(?P<invalid_username>[^ ]+) from (?P<remote_host>.+)"`. Second you need to add another `count` to the `stats` command. This second `count` should count the number of times `ssh_message` is equal to `Accepted publickey for `.

5. Use `transpose` to turn the resulting rows into columns.

## Create a Dashboard

1. Select `Visualization` from the tabs below the search box. In the charts pull-down select `Pie Chart`.

2. Select `Save As` and create a new dashboard with a `Dashboard Title` of your student ID. Click `Save` > `View Dashboard`

## Dashboard Challenge

Using knowledge gained during previous labs, add three additional panels to your new dashboard as per the following specification:

1. A panel showing injected commands. This panel should show unix commands that appear in the logs when Rails Goat's file upload mechanism is abused to execute system commands on your instance.

2. HTTP Codes. A pie chart displaying the distribution of HTTP codes returned by Rails Goat.

3. A panel showing SQL injections / SQL errors. This is a report which extracts SQL related errors in Rails Goat.

See:

![DevSecOps Dashboard](../../_images/dso_dashboard.png)
