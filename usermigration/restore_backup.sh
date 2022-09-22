
#!/bin/bash
read -p "Enter Backup Dir(The dir location of migrated bkp) : " -r  BK_DIR
read -p "Existing files to be backed up to dir : "  -r  BK_CUR
HOM_DIR='/home'

create_bkp_cur()
{

if [ -d $BK_CUR ]
  then
     echo "$BK_CUR exists, so exit"
     exit
  else
     echo "Create $BK_CUR"
     mkdir $BK_CUR
     cp /etc/passwd $BK_CUR/passwd
     cp /etc/group     $BK_CUR/group
     cp /etc/shadow     $BK_CUR/shadow
     cp /etc/gshadow     $BK_CUR/gshadow
     
     #Backup sudoers file
     mkdir $BK_CUR/sudoersd
     cp -rpf /etc/sudoers.d/* $BK_CUR/sudoersd/.
     
     #Backup current home
     mkdir $BK_CUR/home
     cp -rpf $HOM_DIR/* $BK_CUR/home/.
  fi
}

restorebkp()
{
  cat $BK_DIR/addpasswd >> /etc/passwd
  cat $BK_DIR/addgroup $BK_DIR/addgroup_wheel >> /etc/group
  cat $BK_DIR/addshadow >> /etc/shadow
  cat $BK_DIR/addgshadow $BK_DIR/addgshadow_wheel >> /etc/gshadow
  cp  $BK_DIR/sudoersd/* /etc/sudoers.d/.
  chmod 440 /etc/sudoers.d/*
  for i in `cat $BK_DIR/userlist`
  do
    echo "Copying homedir of user : $i"
    cp -rpf $BK_DIR/home/$i $HOM_DIR/.
    chown -R $i:$i $HOM_DIR/$i
  done
}

##################################
create_bkp_cur
restorebkp
