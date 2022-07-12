 

sudo apt list --upgradable 2>/dev/null >> /data/Upgraded-Package-List-$date.txt

sudo apt-get update -y
echo 'APT Update finished...'


sudo apt-get upgrade -y
echo 'APT Upgrade finished...'

