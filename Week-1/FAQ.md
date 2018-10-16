# DevSecOps Frequently Asked Questions

Add your questions and answers here.

## Q: How do you add an upstream repo to a forked repo?
* `git remote add upstream git@github.com:devsecops/bootcamp.git`
* More info on the topic can be found [here](https://help.github.com/articles/configuring-a-remote-for-a-fork/)

## Q: How do I sync changes to an upstream repo to my fork?
* `git fetch upstream`
* `git merge upstream/master`
* More info on the topic can be found [here](https://help.github.com/articles/syncing-a-fork/)

## Q: Regarding attack maps best practices, is there an online resource where we could view different types of attack maps?
I'm especially curious on attacks involving a third-party CDN.

## Q: What are the best practices regarding users, and how do you help prevent users from being the biggest threat to a system's security?
* AWS provide documentation on common industry [Best Practices and how to apply them in your use of AWS](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html):
  * [Lock away your AWS account/root access keys](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#lock-away-credentials)
    * You can also use  Split Custody and/or Dual Control to manage access to root account password or access keys. Better yet, delete the access keys and only have a password backed by MFA.  Manage access the the password and MFA using split custody and/or dual control.
  * [Grant least privilege](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege)
    * Applies to both Human users (IAM Users) and automation (IAM Roles for EC2)
    * Excess privilege creates an easy path for an attacker - don't do it!
  * [Create individual IAM users](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#create-iam-users)
    * Individual accountability is critical to successful access management and also in forensic investigations.
  * [Configure a strong password policy for your users](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#configure-strong-password-policy)
    * Passwords are almost dead.  A strong password, rotated frequently is nearly impossible to remember, so be sure to use MFA in addition.
    * Consider using a password manager (KeePass, LastPass, 1Password, etc.), but be mindful of their pitfalls and limitations.
  * [Enable MFA for privileged users](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#enable-mfa-for-privileged-users)
    * Apply to ALL users!
    * MFA - Just use it!
  * [Separation of Duties] (http://www.sans.edu/research/security-laboratory/article/it-separation-duties)
    * Not explicitly on the AWS list, but it should be.  Max Ramsay from AWS discusses considerations for how to apply Separation of Duties (SoD) (here)(https://blogs.aws.amazon.com/security/post/TxQYSWLSAPYVGT/Guidelines-for-When-to-Use-Accounts-Users-and-Groups)
    * Separation of Duties is an internal controls concept, primarily from financial auditing.  But it is equally applicable in technology.
    * [Another good reference on what SoD is](http://szabo.best.vwh.net/separationofduties.html)
  * [Use roles for applications that run on Amazon EC2 instances](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#use-roles-with-ec2)
    * Don't use long-term credentials (access keys) for EC2 instance access to the AWS API.
    * Always require an MFA token code with use of long-term credentials (access keys)
  * [Delegate by using roles instead of by sharing credentials](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#delegate-using-roles)
    * Don't create or use shared credentials
    IAM Roles and the `AssumeRole` API call are your friends
  * [Rotate credentials regularly](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#rotate-credentials)
    * Change your passwords, access keys, and even MFA/TOTP seed!
  * [Remove unnecessary credentials](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#remove-credentials)
    * Audit/Certify the IAM User accounts & credentials
  * [Use policy conditions for extra security](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#use-policy-conditions)
    * Put conditions/constraints on use (i.e. require MFA, require secure transport, etc.)
  * [Monitor activity in your AWS account](http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#keep-a-log)
    * Keep an eye on use of your stuff!
  * [Manage API Access Keys](http://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html)
  * Also summarized [here](http://blogs.aws.amazon.com/security/post/Tx2OB7YGHMB7WCM/Adhere-to-IAM-Best-Practices-in-2016) and [here](http://blogs.aws.amazon.com/security/post/TxQYSWLSAPYVGT/Guidelines-for-when-to-use-Accounts-Users-and-Groups)
  * [Securosis agrees](https://securosis.com/blog/security-best-practices-for-amazon-web-services)
* Check out the [Control Plane pattern](https://github.com/devsecops/controlplane)

## Q: How do you balance operational needs and security?
Security is a balance for creation and maintenance.  Making tradeoffs is part of all decisions that need to be made.  This essentially starts with identifying your workload and understanding its dimensions plus their importance.  Do you need to support usability? trust? In other words, understanding what is important can help with the priority of requirements and how to balance needs.  With relationship to Security, Operations comes from supporting a workload and its security requirements.  Controls must get built into a workload as part of its general constraints along with operational constraints.  Treating the workload for survivability is typically the way to balance these two disciplines.  Security issues happen more frequently than is discussed in the industry.  If you can imagine security as a frailty consideration then it may be easier to consider. As an Operations engineer it would be useful to know how often you are seeing security exploits being attempted and whether the workload is susceptible.  Remember too, there are ways to test for common security problems without ever signaling the operations team or their monitoring.

## Q: What are flaws of traditional auditing that can be easily solved with devsecops?

## Q: What is the 'rugged' software movement?
At its core, the rugged software movement is about writing software in such a way that it is robust to being used in unanticipated ways.  See https://www.ruggedsoftware.org.  Obviously, secure software is rugged software.

## Q: What is a starting resource for learning more about the types of attacks and vulnerables web-accessible application need to worry about?
While there are a lot of various resources, both on and offline, one very good starting point is the [OWASP](https://www.owasp.org) wiki run by the Open Web Application Security Project.
OWASP even includes a Ruby on Rails-specific listing of common pitfalls of Rails-based applications as the [Ruby on Rails Cheatsheet](https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet)

## Q: Some precautions are obvious to security professionals, but not to an expected user. What approach would you recommend when approaching InfoSec problems in the shoes of a typical user, rather than someone who has expertise in cybersecurity and making certain nothing is overlooked?
Security is hard.  There are known vulnerabilities, weaknesses and mistakes that need to be checked.  And then there is the unknown.  It takes years to get experience and truthfully there will always be creative ways to break something that you haven't anticipated.  The best approach for users is to get the "easy" stuff right.  Checking known issues and making sure they dont become low-hanging fruit for an attacker is always good practice.  Also - there are a variety of tools that you can use to make things better.  Getting basic knowledge about how to test your code and check for common problems goes a long way.

Typical issues to watch out for: bad zoning/blast radius principles, inappropriate components for the level of trust required, no logging or event monitoring, poorly configured passwords, and lack of encryption.  These are among many of the top issues.  Likewise the OWASP Top 10 are useful in helping with web applications.  Avoiding these common issues will make your application a bit more resillient than many on the Internet.  Looking for anomalies is also useful - for example, when a web application gets many 404 error codes it is likely that an attacker is enumerating to find and discover a weakness.  Looking at this information can get you ahead.

## Q: What is a common mistake programmers make in their applications that make their software insecure?

## Q: If I already have an AWS account, can I use it or should I create a new one ?
* If you have data and services you don't mind loosing, feel free to reuse it.
* Ideally, you would create a [separate account](http://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/con-bill-tasks.html) to minimize the "blast radius".

## Q: How do you get buy-in from traditional business units so that the practices taught by DevSecOps can be implemented?

## Q: What are common mistakes programmers make that make their applications less secure?
