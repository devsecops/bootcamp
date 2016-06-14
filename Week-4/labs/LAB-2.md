# Lab 1

**Table of Contents**

- [Search for Invalid SSH Login Attempts](##search-for-invalid-ssh-login-attempts)
- [Splunk Field Extraction](##splunk-field-extraction)
- [Create a Splunk Alert](##create-a-splunk-alert)


# Splunk Extractions and Alerts

In this lab we will be...

---

## Search for Invalid SSH Login Attempts

Search for invalid SSH login attempts made against your instance.

1. Login to Splunk by opening the Splunk Console with your browser.

Splunk Console: [https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F](https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F)

2. Search for your instance's logs. Click `Search & Reporting` and enter `index=main host=<Private DNS>` in the search input box. Select `Last 4 hours` from the time chooser pull-down and hit search.

3. Narrow your search by adding the `sourcetype` of `linux_secure` or the `source` of `/var/log/secure`. What is the difference between these?

4. Add `"Invalid user " AND " from "` to the search string, hit `Enter`.

## Splunk Field Extraction

Extract interesting fields (`invalid_username` & `remote_host`) from our search results (from previous section).

1. Select `+ Extract New Fields` from the bottom left pane.

2. Select any event from the table on the bottom pane and click `Next` on the upper pane next to `Extract Fields`, this should take you to `Select method`.

3. Select `Regular Expression`, click `Next`. Select the username of the invalid user and name it `invalid_username`, click `Add Extraction`.

4. Select the IP address and name it remote_host, click `Add Extraction`. Click `Next` on the upper pane next to `Extract Fields`, click `Next` again. Before clicking `Finish`, copy the `Extraction/Transform` string, it should look something like this: `^(?:[^ \n]* ){7}(?P<invalid_username>[^ ]+) from (?P<remote_host>.+)`. Click `Finish`.

5. If you clicked `Finish` before copying the extraction regular or you simply want to lookup what you just did, select `Settings` > `Fields` > `Field extractions`. Put your username in the search box in the upper right and hit `Enter`. Copy the regular expression under ` 	Extraction/Transform`.

6. Go to `Search & Reporting` by selecting it under `Apps`. Enter `index=main host=<Private DNS>` (same as step 4). Pipe the results to the `rex` command, passing to `rex` the regular expression we just built. Note that `rex` takes a regular expression surrounded by double-quotes. See [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Rex](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Rex).

7. List events containing only invalid users. You can do this by piping the results from `rex` to `search` and passing `invalid_username=*` to `search`.

## Create a Splunk Alert

1. Modify the timeframe for the current search from `Last 4 hours` to `Last 60 minutes`. You can do this by selecting time range picker, choose `Last 60 minutes` and click `search`.

2. From the upper-right select `Save As` > `Alert`. Use these values for the following fields: `Title:` `<STUDENT ID> - Invalid SSH Attempts`, `Schedule:` `Run every hour`, select your favorite number from 0, 15, 30, 45 for the `minutes past the hour` selector. Click `+ Add Actions` > `Add to Triggered Alerts` and select `High` for the `Severity`. Click `Save` and close the dialog by clicking `x` on the upper-right.
