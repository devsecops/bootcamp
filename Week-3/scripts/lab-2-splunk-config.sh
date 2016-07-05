#-----------------------------------------------------------------------------
# Install/configure dependencies, download and install Splunk.
#-----------------------------------------------------------------------------

$ sudo timedatectl set-timezone UTC
$ sudo yum -y install wget
$ wget -O splunkforwarder-6.4.1-debde650d26e-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.4.1&product=universalforwarder&filename=splunkforwarder-6.4.1-debde650d26e-linux-2.6-x86_64.rpm&wget=true'
$ sudo rpm -ivh splunkforwarder-6.4.1-debde650d26e-linux-2.6-x86_64.rpm

#---------------------------
# Configure Splunk.
#---------------------------

#Configure outputs:
echo "[tcpout]
defaultGroup = dso-autolb-group

[tcpout:dso-autolb-group]
disabled = false
dropEventsOnQueueFull = 10
server = appliance:9997
sslCertPath = \$SPLUNK_HOME/etc/auth/server.pem
sslPassword = password
sslRootCAPath = \$SPLUNK_HOME/etc/auth/cacert.pem
sslVerifyServerCert = false
useACK = false" | sudo tee /opt/splunkforwarder/etc/system/local/outputs.conf

# Configure inputs:
echo "[default]
host = \$decideOnStartup

[monitor:///home/ec2-user/railsgoat/log/]
recursive=true

[monitor:///var/log/]
recursive=true" | sudo tee /opt/splunkforwarder/etc/system/local/inputs.conf