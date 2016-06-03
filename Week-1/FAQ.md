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

##### How do you balance operational needs and security?

##### What are flaws of traditional auditing that can be easily solved with devsecops?

##### What is the 'rugged' software movement?
At its core, the rugged software movement is about writing software in such a way that it is robust to being used in unanticipated ways.  See https://www.ruggedsoftware.org.  Obviously, secure software is rugged software.
