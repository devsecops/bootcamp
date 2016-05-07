# Mac OS X & Linux

## Do you Git it?

1. Check if your machine has Git installed already or follow the procedure to [Install git](https://help.github.com/articles/set-up-git/#setting-up-git):
```
git --version
```

## Do you even Ruby, bro?
1. Check if your machine has rbenv installed already or follow the procedure to [Install rbenv](https://github.com/rbenv/rbenv#installation):
```
rbenv --version
```

  **Compatibility note:** rbenv is incompatible with RVM. Please make sure to fully uninstall RVM and remove any references to it from your shell initialization files before installing rbenv.

1. Check if your machine has ruby 2.2.X installed already or follow the procedure to [Install 2.2.X](https://developer.xamarin.com/guides/testcloud/calabash/configuring/osx/updating-ruby-using-rbenv/#Installation):
```
ruby --version
```

1. To install ruby 2.2.2 using rbenv, run:
```
rbenv install 2.2.2
rbenv rehash
rbenv global 2.2.2
rbenv rehash
```

1. Install aws-sdk-core gem
```
gem update --system
rbenv rehash
gem install aws-sdk
rbenv rehash
```

## So you use AWS CLI, eh?
1. Check if your machine has AWS CLI installed already.
In your terminal, run:
```
aws help
```
If you do not have AWS CLI proceed to install AWS CLI, you need:
    1. python
    2. pip

1. Check if your machine has Python installed, or follow the procedure to [Install Python](http://docs.aws.amazon.com/cli/latest/userguide/installing.html#install-python):
```
python --version
```

1. Check if your machine has Pip installed, or follow the procedure to [Install Pip](http://docs.aws.amazon.com/cli/latest/userguide/installing.html#install-pip):
```
pip --help
```

1. Install the AWS CLI only for the current user, run:
```
sudo pip install awscli
```

1. If you see an error regarding the version of six that came with distutils in El Capitan, use the --ignore-installed option:
```
sudo pip install awscli --ignore-installed six
```

---
## References:
GIT: https://help.github.com/articles/set-up-git

RUBY: https://github.com/rbenv/rbenv

AWS CLI: http://docs.aws.amazon.com/cli/latest/userguide/installing.html
