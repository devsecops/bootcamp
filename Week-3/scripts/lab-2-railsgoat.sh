# install Rails Goat dependencies
sudo yum -y install git git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-7.noarch.rpm
sudo yum -y install nodejs
sudo yum -y install mariadb mariadb-server mariadb-devel
sudo systemctl start mariadb.service

# install Ruby
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile

source ~/.bash_profile
rbenv install -v 2.3.1
rbenv global 2.3.1

# install bundler
ruby -v
gem install bundler --no-ri --no-rdoc

# setup Rails Goat
cd ~
git clone https://github.com/OWASP/railsgoat.git
cd railsgoat
touch log/mysql.log
export RAILS_ENV=mysql
bundle install
bundle exec rake db:setup