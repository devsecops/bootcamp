# Lab 2

**Table of Contents**

- [Search for Invalid SSH Login Attempts](##search-for-invalid-ssh-login-attempts)
- [Splunk Field Extraction](##splunk-field-extraction)
- [Splunk Statistics](##splunk-statistics)
- [Create a Splunk Alert](##create-a-splunk-alert)


# Splunk Extractions, Stats and Dashboards

In this lab we will be searching for invalid SSH login attempts, extracting fields of interest and creating a dashboard.

**Resources:**

* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Search](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Search)
* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Rex](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Rex)
* [http://regexr.com/](http://regexr.com/)
* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Stats](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Stats)
* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Eval](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Eval)

---

## Search for Invalid SSH Login Attempts

Search for invalid SSH login attempts made against your instance.

1. Login to Splunk by opening the Splunk Console with your browser. Splunk Console: [https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F](https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F)

2. Search for your instance's logs. Click `Search & Reporting` and enter `index=main host=<Private DNS>` in the search input box. Select `Last 4 hours` from the time chooser pull-down and hit search. `Private DNS` is your intance's private DNS name.

3. Narrow your search by adding the `sourcetype` of `linux_secure` or the `source` of `/var/log/secure`. What is the difference between these?

4. Add `"Invalid user " AND " from "` to the search string, hit `Enter`. If you do not get any results, attempt to SSH into your instance with an invalid username/password.

## Splunk Field Extraction

Extract interesting fields (`invalid_username` & `remote_host`) from our search results (from previous section).

1. Select `+ Extract New Fields` from the bottom left pane.

2. Select any event from the table on the bottom pane and click `Next` on the upper pane next to `Extract Fields`, this should take you to `Select method`.

3. Select `Regular Expression`, click `Next`. Select the username of the invalid user and name it `invalid_username`, click `Add Extraction`.

4. Select the IP address and name it remote_host, click `Add Extraction`. Click `Next` on the upper pane next to `Extract Fields`, click `Next` again. Before clicking `Finish`, copy the `Extraction/Transform` string, it should look something like this: `^(?:[^ \n]* ){7}(?P<invalid_username>[^ ]+) from (?P<remote_host>.+)`. Click `Finish`.

5. If you clicked `Finish` before copying the extraction regular or you simply want to lookup what you just did, select `Settings` > `Fields` > `Field extractions`. Put your username in the search box in the upper right and hit `Enter`. Copy the regular expression under ` 	Extraction/Transform`.

6. Go to `Search & Reporting` by selecting it under `Apps`. Enter `index=main host=<Private DNS> sourcetype="linux_secure"`. Pipe the results to the `rex` command, passing to `rex` the regular expression we just built. Note that `rex` takes a regular expression surrounded by double-quotes. See resources above.

7. List events containing only invalid users. You can do this by piping the results from `rex` to `search` and passing `invalid_username=*` to `search`.

## Splunk Statistics

Run statistics on valid vs invalid SSH login attempts.

1. Modify the search query to also extract characters preceding invalid usernames into a field.

  Your search query should look *something* like: `index=main host=ip-10-0-0-0.us-west-2.compute.internal sourcetype="linux_secure" | rex "(?<ssh_message>Invalid user )(?P<invalid_username>[^ ]+) from (?P<remote_host>.+)" | search ssh_message=*`. Also select `All time` from the time range picket.

2. Count the invalid SSH login attempts.

  Use `stats` and `eval` functions to count the number of times `ssh_message` is equal to `"Invalid user "`, name the resulting column `invalid`.

  Your new query should looks *something* like: `index=main host=ip-10-0-0-0.us-west-2.compute.internal sourcetype="linux_secure"| rex "(?<ssh_message>Invalid user )(?P<username>[^ ]+) from (?P<remote_host>.+)" | stats count(eval(ssh_message="Invalid user ")) as invalid`

3. In the same search query modify the regular expression passed to the `rex` command to also extract valid SSH logins into the `ssh_message` field.

  Extract `Accepted publickey for ` into the `ssh_message` field by appending to the regular expression used above. This should look something like `"(?<ssh_message>Accepted publickey for |Invalid user )(?P<username>[^ ]+) from (?P<remote_host>.+)"`.

4. Now using the `stats` command extract a new field which keeps count of `valid` SSH logins.

  Add another `count` section to the `stats` command. This second `count` should count the number of times `ssh_message` is equal to `Accepted publickey for `. The first count command can serve as an template for your second command.

## Create a Dashboard

Create a dashboard displaying valid vs invalid SSH login attempts.

1. Pipe the results to `transpose` to turn the resulting rows into columns.

2. Select `Visualization` from the tabs below the search box. In the charts pull-down select `Pie Chart`.

3. Select `Save As` and create a new dashboard with a `Dashboard Title` of your student ID. Click `Save` > `View Dashboard`
