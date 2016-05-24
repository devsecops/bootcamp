# -*- mode: ruby -*-
# vi: set ft=ruby :

BASIC_SETUP = <<SCRIPT
  echo "UPDATE LINUX REPOS"
  sudo yum update -y

  echo "INSTALLING GIT, VIM, WGET"
  sudo yum install -y git vim wget xz-libs
  sudo yum groupinstall "Development Tools" -y
SCRIPT

AWS_SETUP = <<SCRIPT
  echo "INSTALLING PYTHON DEPENDENCIES"
  wget http://www.python.org/ftp/python/2.7.11/Python-2.7.11.tar.xz && wget http://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz
  xz -d Python-2.7.11.tar.xz && xz -d Python-3.4.3.tar.xz
  tar -xvf Python-2.7.11.tar && tar -xvf Python-3.4.3.tar
  cd /home/vagrant/Python-2.7.11/ && ./configure && make && sudo make install
  cd /home/vagrant/Python-3.4.3/ && ./configure && make && sudo make install

  echo "INSTALLING PIP"
  cd /home/vagrant/
  curl -o- https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm > epel7.rpm
  sudo rpm -Uvh epel7.rpm
  sudo yum update && sudo yum install -y python-pip
  sudo pip install --upgrade pip

  echo "INSTALLING AWS CLI"
  sudo pip install awscli
SCRIPT

RUBY_SETUP = <<SCRIPT
echo "INSTALLING RUBY DEPENDENCIES"
sudo yum install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev openssl-devel readline-devel zlib-devel

echo "INSTALLING RBENV"
git clone https://github.com/rbenv/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile

echo "RBENV INIT"
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile

echo "INSTALLING RUBY-BUILD"
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv rehash

echo "DISABLE RUBY DOCS"
echo "gem: --no-document" >> /home/vagrant/.gemrc

rbenv install 2.3.1
rbenv global 2.3.1
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = 'centos/7'

  config.vm.provider 'virtualbox' do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # config.vm.provider 'vmware_fusion' do |v|
  #   v.vmx['memsize'] = '2048'
  #   v.vmx['numvcpus'] = '2'
  # end

  config.vm.provision :shell, inline: BASIC_SETUP,  privileged: false
  config.vm.provision :shell, inline: RUBY_SETUP,   privileged: false
  config.vm.provision :shell, inline: AWS_SETUP,    privileged: false

end
