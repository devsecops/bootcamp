# Lab 3

**Table of Contents**

- [Create Volumes](##create-volumes)
- [Mount the Volumes](##mount-the-volumes)
- [Jenkins Forensic Analysis](##jenkins-forensic-analysis)
- [JBoss Forensic Analysis](##jboss-forensic-analysis)

# Perform Forensic Analysis

*Resources:*

- [Block Device Mapping](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html)
- [Linux Shell Survival Guide](http://digital-forensics.sans.org/media/linux-shell-survival-guide.pdf)
- [SIFT Cheat Sheet](http://digital-forensics.sans.org/media/sift_cheat_sheet.pdf)
- [Forensics Wiki](http://forensicswiki.org/wiki/Main_Page)

## Create Volumes

1. Assume the incident response role in the forensics account.

  ```
$ unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID
$ assumer -a 439426457924 -r human/dso/TGT-dso-IncidentResponse \
    -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-IncidentResponse \
    -o dso -g -u $AWS_USERNAME
  ```

2. From the Snapshots tab in the EC2 console, select your snapshots (JBoss & Jenkins) hosts.

3. For each snapshot, create a volume by selecting `Actions` >  `Create Volume`. Select `us-west-2c` from the `Availability Zone` pull-down (same as bastion). Click `Create`, note the volume ID and click `Close`.

4. Navigate to the Volumes tab, for each of the newly created volumes, wait for the volume state to be `available`.

5. For each of the volumes, select `Actions` > `Attach Volume`. For the `Instance` field, use the bastion instance ID. Make note of the `Device` ID (e.g., `/dev/sdf` - the Linux device ID) that becomes present once the bastion instance is selected. Click `Attach`.

## Mount the Volumes

1. SSH into the bastion.

  ```
$ ssh <YOUR STUDENT ID>@52.42.52.211
  ```

2. Using the resources above, translate the Linux device ID into its Xen (AWS hypervisor) equivalent. E.g., `/dev/sdf` would become `/dev/xvdf`. This is the `AWS_DEVICE_ID`.

3. List the partitions on each of your newly attached disks. Note that the Jenkins volume will have a different AWS device ID than the JBoss volume.

  E.g.,

  ```
$ sudo fdisk -l <AWS_DEVICE_ID>
  ```

  It should be clear that the Jenkins volume has one partition while the JBoss volume has two partitions.

4. Mount the first (Jenkins) and second (JBoss) disk partition on each of your newly mounted volumes under their corresponding mount points.

  ```
$ sudo mount -o ro <AWS_DEVICE_ID>1 /mnt/<YOUR STUDENT ID>/jenkins
$ sudo mount -o ro <AWS_DEVICE_ID>2 /mnt/<YOUR STUDENT ID>/jboss
  ```

  If this mounting the JBoss volume errors out, try:

  ```
$ sudo mount -o ro,nouuid <AWS_DEVICE_ID>2 /mnt/<YOUR STUDENT ID>/jboss
  ```

## Jenkins Forensic Analysis

1. Take a look at the auth log.

  ```
$ sudo cat /mnt/<YOUR STUDENT ID>/jenkins/var/log/auth.log
  ```

  What does this log tell you about system users?

2. Find the username for the user that was denied sudo actions.

  ```
$ sudo cat /mnt/<YOUR STUDENT ID>/jenkins/var/log/auth.log | grep sudo
  ```

  Which user was denied using sudo?

3. List the `jenkins` user home directory.

  ```
$ ls -a /mnt/<YOUR STUDENT ID>/jenkins/var/lib/jenkins
  ```

  How would you determine what the `jenkins` user home directory is?

4. List all files in the filesystem and their timestamps.

  ```
$ sudo find /mnt/<YOUR STUDENT ID>/jenkins -type f -printf '%T@ %p\n' > jenkins_files.txt
$ sudo chown <YOUR STUDENT ID>:dso jenkins_files.txt
  ```

5. List the last 200 modified files. This should give us an idea of where the attack occurred.

  ```
$ cat jenkins_files.txt | sort -n | tail -200 | cut -f2- -d" "
  ```

  Do any of the listed files grab your attention?

6. Let's analyze a specific log file.

  ```
$ cat /mnt/<YOUR STUDENT ID>/jenkins/var/lib/jenkins/jobs/Student10/builds/2/log
  ```

  What do we see here? Can you see see evidence of tampering? What did this user do in the system?

7. Determine which other hosts the user probed.

  E.g.,

  ```
$ grep ping /mnt/<YOUR STUDENT ID>/jenkins/var/lib/jenkins/jobs/Student10/builds/2/log
  ```

8. Determine the last several actions the user performed.

  ```
$ tail /mnt/<YOUR STUDENT ID>/jenkins/var/lib/jenkins/jobs/Student10/builds/2/log
  ```

  Note the files in `/tmp` that were executed, namely `/tmp/si8xE3`.

9. It seems as if the user ran a custom binary, let's see what it does. Note, you would never run this on a production host. This is intended to be run in a sandbox environment.

  ```
$ strace /mnt/<YOUR STUDENT ID>/jenkins/tmp/si8xE3
execve("/mnt/<YOUR STUDENT ID>/jenkins/tmp/si8xE3", ["/mnt/<YOUR STUDENT ID>/jenkins/tmp/si8xE3"], [/* 25 vars */]) = 0
[ Process PID=19457 runs in 32 bit mode. ]
mprotect(0xffd85000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [4], 4) = 0
bind(3, {sa_family=AF_INET, sin_port=htons(10008), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
listen(3, 4292369220)                   = 0
accept(3,
  ```

  What is this binary doing..? It looks like it is opening a listening port (`10008`) on all interfaces (`0.0.0.0`).


## JBoss Forensic Analysis

Using the techniques demonstrated above, determine the actions performed by the attacker.

Hints:

List latest modified files:

```
$ sudo find /mnt/<YOUR STUDENT ID>/jboss -type f -printf '%T@ %p\n' \
  | sort -n | tail -100 | cut -f2- -d" "
```

List installed application on JBoss:

```
$ sudo ls /mnt/student1/jboss/home/ec2-user/jboss-5.1.0.GA/server/default/work/jboss.web/localhost/
```

Use strings to look for suspicious *strings* in applications (WAR files).

E.g.,

```
$ sudo strings /mnt/student1/jboss/home/ec2-user/jboss-5.1.0.GA/server/default/deploy/kSHcSJwHujbHSqD.war
```

## Challenge

* Perform forensic analysis of your Rails Goat hosts
* Write a fictitious report of what happened
