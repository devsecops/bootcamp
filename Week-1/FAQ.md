# DevSecOps Frequently Asked Questions

Add your questions and answers here.

##### How do you add an upstream repo to a forked repo?
* `git remote add upstream git@github.com:devsecops/bootcamp.git`
* More info on the topic can be found [here](https://help.github.com/articles/configuring-a-remote-for-a-fork/)

##### How do I sync changes to an upstream repo to my fork?
* `git fetch upstream`
* `git merge upstream/master`
* More info on the topic can be found [here](https://help.github.com/articles/syncing-a-fork/)

##### Regarding attack maps best practices, is there an online resource where we could view different types of attack maps?  I'm especially curious on attacks involving a third-party CDN.

##### What are the best practices regarding users, and how do you help prevent users from being the biggest threat to a system's security?

##### How do you balance operational needs and secuirty?

##### What are flaws of traditional auditing that can be easily solved with devsecops?

##### If I already have an AWS account, can I use it or should I create a new one ?
* If you have data and services you don't mind loosing, feel free to reuse it. 
* Ideally, you would create a [separate account](http://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/con-bill-tasks.html) to minimize the "blast radius".
