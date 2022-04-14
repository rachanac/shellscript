#!/bin/bash

BKP_OLD=/meltwater/usr_bkp_admn-qas-004/meltwater/home
BKP_NEW=/meltwater/usr_bkp_newpc/home_bkp_newpc

read -p "Enter User list file: " -r USERS_LIST

for USER in `cat $USERS_LIST`
do
  echo "Deleting USER: $USER"
  userdel $USER
  rm -rf /home/$USER
  if [ -d /home/$USER ]
  then
     echo "Home dir /home/$USER still exist"
  else
     echo " Homne Dir : /home/$USER Deleted"
  fi

  echo "Creating USER: $USER"
  useradd -m  -d /home/$USER -s /bin/bash $USER

  if [ -d  $BKP_OLD/$USER ]
  then
    echo "Copying home from $BKP_OLD/$USER"
    cp -rpf $BKP_OLD/$USER /home/.
  elif [ -d $BKP_NEW/$USER ]
  then 
    echo "Copying home from $BKP_NEW/$USER"
    cp -rpf $BKP_NEW/$USER /home/.
  else
    echo "Home Backup not available"
  fi
  echo "Correcting permissions"
  chown -R $USER:$USER /home/$USER
  ls -al /home/$USER
  ls -al /home/$USER/.ssh
done
