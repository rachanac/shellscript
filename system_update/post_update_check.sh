work_dir="/tmp/post"

echo "System Uptime"
uptime
echo "--------------------------"

echo "Check if there is any package upgradable...."
sudo apt-get update
echo "-------------------------"

echo "Checking the service Status..............."
for i in `cat $work_dir/t |awk '{print $7}'  |cut -d "/" -f2 |cut -d: -f1`; do echo "Service $i `systemctl is-active $i`"; done
echo "--------------------------------"

echo "Verifying the mount points..................."
df -h |awk '{print $6}' > $work_dir/post_m
cmp --silent  $work_dir/pre_m $work_dir/post_m  && echo "Successfully mounted \n  Current mount details: `cat $work_dir/post_m`"  || echo "ERROR: There is a CONFLICT in mount points!!!!\n ----- \n Current mount details: `cat $work_dir/post_m` \n---------------\n  Required : `cat  $work_dir/post_m`"
