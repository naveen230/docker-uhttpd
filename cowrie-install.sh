#set root password
sudo echo "root:Test123!" | sudo chpasswd
#sudo-update-upgrade
sudo apt-get update -y && apt-get upgrade
#install dependencies
sudo apt-get install git python-dev python-openssl openssh-server python-pyasn1 python-twisted authbind
#set cowrie to listen to port22
touch /etc/authbind/byport/22
chown cowrie /etc/authbind/byport/22
chmod 777 /etc/authbind/byport/22
#switch to test user
su cowrie
#install cowrie
Mkdir cowrie
Cd cowrie
git clone https://github.com/cowrie/cowrie.git
cd cowrie
#script to create script
touch start.sh
{ printf %s authbind --deep; cat <./start.sh; } >/tmp/output_file
mv -- /tmp/output_file ./start.sh
#vi start.sh (add authbind --deep)
rm -rf /tmp/output_file
#change default port to listen to 8742
{ printf %s"\n" Port 8742;  cat </etc/ssh/sshd_config; } >/tmp/output_file
mv -- /tmp/output_file /etc/ssh/sshd_config



{ printf %s Port-8742; cat </etc/ssh/sshd_config; } >/tmp/output_file
mv -- /tmp/output_file /etc/ssh/sshd_config

