# DevSecOps Frequently Asked Questions

Add your questions and answers here.

#####How do you add an upstream repo to a forked repo so you can pull down change?
* `git remote add upstream git@github.com:devsecops/bootcamp.git`
* More info can be found [here](https://help.github.com/articles/configuring-a-remote-for-a-fork/)

#####How do you pull upstream changes from into a fork?
* `git fetch upstream`
* `git merge upstream\master`
* More info can be found [here](https://help.github.com/articles/syncing-a-fork/)

#####Regarding attack maps best practices, is there an online resource where we could view different types ofattack maps? I am especially curious about attacks involving a third-party CDN.
