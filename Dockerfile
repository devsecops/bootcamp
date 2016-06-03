FROM centos:7

# Disclaimer: this is not an audited/hardend image build--merely a quick migration
# from the 'current' vagrant build. It should not be used as a base for any production environment.

RUN yum update -y && yum groupinstall -y development
RUN yum update -y && yum install -y git vim wget zsh

# In order to get python for Centos7, we have to use the extended epel repo
RUN yum install -y epel-release && yum install -y python34 python-pip && \
  pip install --upgrade pip && \
  pip install awscli

# Ruby
ENV RUBY_VERSION 2.3.1
ENV BUNDLER_VERSION 1.11
ENV PATH /usr/local/rbenv/bin:$PATH

RUN yum install -y openssl-devel readline-devel zlib-devel

RUN git clone --depth=1 https://github.com/rbenv/rbenv.git /usr/local/rbenv && \
git clone --depth=1 https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build && \
/usr/local/rbenv/plugins/ruby-build/install.sh && \
echo 'eval "$(rbenv init - zsh)"' >> /root/.zshrc && \
eval "$(rbenv init -)" && \
rbenv install $RUBY_VERSION  && \
rbenv global $RUBY_VERSION  && \
gem install bundler --version "$BUNDLER_VERSION" && \
bundle config install --no-rdoc --no-ri && \
bundle config update --no-rdoc --no-ri

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["zsh"]
