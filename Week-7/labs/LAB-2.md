# Lab 2

**Table of Contents**

- [Take Forensic Snapshots](##take-forensic-snapshots)
- [Escrow Forensic Snapshots](##escrow-forensic-snapshots)
- [Automation](##automation)

# Capture Forensic Snapshots

In this lab we will be taking forensic snapshots of the two hosts that were compromised last week. We will also escrow these snapshots into the forensics account for later analysis.

*Resources:*

- [Creating an Amazon EBS Snapshot](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-creating-snapshot.html)

## Take Forensic Snapshots

Take forensic snapshots of the two hosts that were compromised last week.

1. Open the AWS Console using the incident response role in the DSO target account.

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 717986480831 -r human/dso/TGT-dso-IncidentResponse \
  -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-IncidentResponse \
  -o dso -g -u $AWS_USERNAME
  ```

2. Navigate to the `Instances` tab in the EC2 console and take snapshots of the two instances compromised last week.

* i-02eb8dc3e56b3d9a4 (JBoss)
* i-0329bef7dca71b547 (Jenkins)

  Snapshot procedure, for each instance:

  1. Select the instance, under the bottom pane select its `Root device`.
  2. Select (Click) the `EBS ID` (e.g, `vol-d032c359`)
  3. Select the EBS volume, then click `Actions` > `Create Snapshot`
  4. Set `Name` to the instance ID and `Description` to your student ID. Click Create.
  5. Make a note of the snapshot ID and select it from the Create Snap dialog. This should take you to the Snapshots section of the console.
  6. With your newly created snapshot selected, select `Actions` and select `Modify Permissions`.
  7. Ensure that the snapshot remains `Private` and put the forensic account number (`439426457924`) in the `AWS Account Number` field and click Add Permission. Warning: making it public would give anyone with an AWS account access to the snapshot and its contents.
  8. Click save.

## Escrow Forensic Snapshots

Copy the snapshots into the forensics account.

1. Assume the incident response role in the forensics account if your session has timed out.

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 439426457924 -r human/dso/TGT-dso-IncidentResponse \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-IncidentResponse \
    -o dso -g -u $AWS_USERNAME
  ```

2. Navigate to the Snapshots tab in the EC2 console.
3. Select Private Snapshots and select one of your snapshots.
4. From `Actions`, select `Copy`.
5. Click `Copy` on the `Copy Snapshot` dialog.
6. Go back to step 2 and repeat these steps for the second snapshot.

## Automation

Now that we have done this the *hard* way, let's automate the process, the *selfie* way.

1. Clone Selfie.

  ```
$ git clone https://github.com/devsecops/selfie.git
  ```

2. Build and install the Selfie gem.

  ```
$ cd selfie
$ gem build selfie.gemspec
$ gem install selfie-1.0.0.gem
  ```

3. Familiarize yourself with selfie.

  ```
$ selfie
Usage: selfie [options]
    -r, --region REGION              AWS Region (default: us-west-2)
    -a, --target-account ACCOUNT     Target AWS account to snapshot, without dashes
    -R, --target-role ROLE           Incident response target account role name
    -n INSTANCEID,                   Comma-separated list of instances to snapshot
        --target-instance-list
    -i, --ir ACCOUNT                 The incident response (IR) account to copy snapshots into
    -A, --control-account ACCOUNT    The control plane account number
    -c, --control-role ROLE          Incident response control account role name
    -u, --username USERNAME          Your IAM username, used to grab MFA serial number
    -t, --ticket-id TICKETID         The ticket ID, will be added to snapshot description
    -f, --file-path FILEPATH         The file path to load and resume from
    -p, --profile-name NAME          The AWS credentials profile name
    -b, --bucket BUCKET              The bucket in incident response account for saving security configuration
    -h, --help                       Show this message
        --version                    Show version
  ```

3. Using selfie take snapshots and escrow them.

* Target account: `717986480831`
* Incident response (forensics) account: `439426457924`
* Control account: `100352119871`
* Instances: `<INSTANCE IDS>`
* Username: `student<STUDENT ID NUMBER>`
* Ticket ID: `STDNT-<STUDENT ID NUMBER>`

Remember to unset the old environment variables before running selfie.

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
  ```

## Challenge

Update Selfie to:

* collect all configuration data: instances, load-balancers, security-groups, db-instances, users and roles configuration.
* save configuration data to the bucket specified by the command line
* if you are proud of your code, contribute it as a Pull Request.
