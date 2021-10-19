
#######################################################
##################### Disable firewalld ###############
#######################################################
systemctl stop firewalld
systemctl disable firewalld

site_string=$(echo $json | jq -r $CONFIG_LOCATION.site_string)
count=$(echo $json | jq -r $CONFIG_LOCATION.count)
master_public_ip=$(echo $json | jq -r $CONFIG_LOCATION.master_public_ip)


file="splunk-8.1.1-08187535c166-linux-2.6-x86_64.rpm"
version="8.1.1"
url="https://download.splunk.com/products/splunk/releases/$version/linux/$file"
wget -O $file $url
chmod 744 $file
mkdir -p /opt/splunk
rpm -i $file

# template basic conf files
cat << EOF > /opt/splunk/etc/system/local/indexes.conf
[default]
repFactor = auto
tsidxWritingLevel=2
EOF

# template other conf files

cat << EOF > /opt/splunk/etc/system/local/inputs.conf
[default]
host = idx-$count

[splunktcp://9997]
disabled = 0
EOF

cat << EOF > /opt/splunk/etc/system/local/server.conf
[diskUsage]
minFreeSpace = 1000

[general]
site = $site_string
serverName = idx-$count

[clustering]
mode = slave
pass4SymmKey = democluster
master_uri = https://$master_public_ip:8089

[replication_port://9887]
EOF

cat << EOF > /opt/splunk/etc/system/local/user-seed.conf
USERNAME = admin
PASSWORD = $password
EOF

cat << EOF > /opt/splunk/etc/system/local/limits.conf
[diskUsage]
minFreeSpace = 500
EOF

echo "Start splunk"
/opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt
