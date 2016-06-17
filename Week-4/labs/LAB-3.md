# Lab 3

**Table of Contents**

- [Reporting Security Events](##reporting-security-events)
- [Create a Splunk Alert](##create-a-splunk-alert)
- [Dashboard Challenge](##dashboard-challenge)


# Advanced Splunk Search and Dashboards

In this lab we will be performing more complex searches and adding to our security dashboard.

**Resources:**

* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Search](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Search)
* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Rex](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Rex)
* [http://regexr.com/](http://regexr.com/)
* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Stats](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Stats)
* [http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Eval](http://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Eval)


---

## Reporting Security Events

Create a report showing when Rails Goat file upload mechanism is abused to perform command injection.

1. Login to Splunk by opening the Splunk Console with your browser. Splunk Console: [https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F](https://54.186.140.211/en-US/account/login?return_to=%2Fen-US%2F)

2. Click on `Search & Reporting` and search for your instance's Rails Goat logs, these should be under the `main` index. E.g., `index=main host=<Private DNS> source="/home/ec2-user/railsgoat/log/mysql.log"`. Select `All time` from the time range picker and click `Search`.

3. Search for events containing `filename`. Do you see any events? If not, go back to Week 3 Lab 3 and do Exercise 2.

4. Pipe the current search results to `rex` to extract the injected command into a new field named `cmd`. Do NOT use the field extractor UI (`+ Extract New Fields`) for this exercise.

  Example: if my event returns something like `...filename=\"test.rtf;+mkdir+pwn\"\r\nContent-Type:...` I am interested in capturing everything between the first plus-sign and the following back-slash, i.e., `mkdir+pwn`.

  Hint 1: `| rex " filename=(?<cmd>.*) .*"`. Hint 2: escaping back-slashes within `rex` is special, you need 3 back-slashes to escape one back-slash.

5. Pipe the results to another `rex` command to substitute the plus-signs (`+`) with spaces (` `).

  To do this you will need to 1) filter on the `cmd` field (`| rex field=cmd`), 2) put `rex` in `sed` mode (see resources above) and 3) substitute the plus-sign with a space using a `sed` style regular expression, e.g., `"s/\+/ /g"`.

6. Use the `stats` command to display the `values` of `cmd` by `host`.

7. Save the search as a report. Click `Save As` > `Report` and enter `<STUDENT ID> - Cmd Injection` as the report title and click `Save`. Click `Add to Dashboard`, select `Existing` and select the dashboard you created during the last lab. Click `Save` and click `View Dashboard`.


## Create a Splunk Alert

Create a Splunk alert that will trigger when Rails Goat file upload mechanism is abused to perform command injection.

1. Go to reports, open the report you just created. Select `Edit` > `Open in Search`

2. Modify the timeframe for the current search from `All time` to `Last 60 minutes`. You can do this by selecting time range picker, choose `Last 60 minutes` and click `search`.

3. From the upper-right select `Save As` > `Alert`. Use these values for the following fields: `Title:` `<STUDENT ID> - Cmd Injection`, `Schedule:` `Run every hour`, select the next closest interval to the current time from 0, 15, 30, 45 for the `minutes past the hour` selector. Click `+ Add Actions` > `Add to Triggered Alerts` and select `High` for the `Severity`. Click `Save` and close the dialog by clicking `x` on the upper-right.

## Dashboard Challenge

Using knowledge gained during previous labs, add two additional panels to your new dashboard as per the following specification:

1. HTTP Codes. A pie chart displaying the distribution of HTTP codes returned by Rails Goat.

2. A panel showing SQL injections / SQL errors. This is a report which extracts SQL related errors in Rails Goat.

See:

![DevSecOps Dashboard](../../_images/dso_dashboard.png)
