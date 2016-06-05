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

## Q: How do you balance operational needs and security?
Security is a balance for creation and maintainance.  Making tradeoffs is part of all decisions that need to be made.  This essentially starts with identifying your workload and understanding its dimensions plus their importance.  Do you need to support usability? trust? In other words, understanding what is important can help with the priority of requirements and how to balance needs.  With relationship to Security, Operations comes from supporting a workload and its security requirements.  Controls must get built into a workload as part of its general constraints along with operational constraints.  Treating the workload for survivability is typically the way to balance these two disciplines.  Security issues happen more frequently than is discussed in the industry.  If you can imagine security as a frailty consideration then it may be easier to consider. As an Operations engineer it would be useful to know how often you are seeing security exploits being attempted and whether the workload is susceptible.  Remember too, there are ways to test for common security problems without ever signaling the operations team or their monitoring.  

## Q: What are flaws of traditional auditing that can be easily solved with devsecops?

## Q: What is the 'rugged' software movement?
At its core, the rugged software movement is about writing software in such a way that it is robust to being used in unanticipated ways.  See https://www.ruggedsoftware.org.  Obviously, secure software is rugged software.

## Q: What is a starting resource for learning more about the types of attacks and vulnerables web-accessible application need to worry about?
While there are a lot of various resources, both on and offline, one very good starting point is the [OWASP](https://www.owasp.org) wiki run by the Open Web Application Security Project.
OWASP even includes a Ruby on Rails-specific listing of common pitfalls of Rails-based applications as the [Ruby on Rails Cheatsheet](https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet)

## Q: Some precautions are obvious to security professionals, but not to an expected user. What approach would you reccommend when approaching InfoSec problems in the shoes of a typical user, rather than someone who has expertise in cybersecurity and making certain nothing is overlooked?
Security is hard.  There are known vulnerabilities, weaknesses and mistakes that need to be checked.  And then there is the unknown.  It takes years to get experience and truthfully there will always be creative ways to break something that you haven't anticipated.  The best approach for users is to get the "easy" stuff right.  Checking known issues and making sure they dont become low-hanging fruit for an attacker is always good practice.  Also - there are a variety of tools that you can use to make things better.  Getting basic knowledge about how to test your code and check for common problems goes a long way.

Typical issues to watch out for: bad zoning/blast radius principles, inappropriate components for the level of trust required, no logging or event monitoring, poorly configured passwords, and lack of encryption.  These are among many of the top issues.  Likewise the OWASP Top 10 are useful in helping with web applications.  Avoiding these common issues will make your application a bit more resillient than many on the Internet.  Looking for anomalies is also useful - for example, when a web application gets many 404 error codes it is likely that an attacker is enumerating to find and discover a weakness.  Looking at this information can get you ahead.

## Q: What is a common mistake programmers make in their applications that make their software insecure?

## Q: If I already have an AWS account, can I use it or should I create a new one ?
* If you have data and services you don't mind loosing, feel free to reuse it. 
* Ideally, you would create a [separate account](http://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/con-bill-tasks.html) to minimize the "blast radius".

## Q: How do you get buy-in from traditional business units so that the practices taught by DevSecOps can be implemented?

## Q: What are common mistakes programmers make that make their applications less secure?



