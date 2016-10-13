createpw() {

if [ ${SSH_PASS} == "generatepw" ]; then
	   SSH_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')
  	 
  	 sed -i "s/SSH_PASS=\"generatepw\"/SSH_PASS=\"$SSH_PASS\"/g" /root/userconfig.cfg
fi


#Check SSH PORT
declare -A BLOCKED_PORTS='(
        [21]="1"
        [22]="1"
        [25]="1"
        [53]="1"
        [80]="1"
        [143]="1"
        [587]="1"
        [990]="1"
        [993]="1"
        [443]="1"
        [2008]="1"
        [10011]="1"
        [30033]="1"
        [41144]="1")'


if [ ${SSH_PORT} == 'generateport' ]; then

    #Generate SSH Port
    randomNumber="$(($RANDOM % 1023))"

    #return a string
    SSH_PORT=$([[ ! -n "${BLOCKED_PORTS["$randomNumber"]}" ]] && printf "%s\n" "$randomNumber")
    sed -i "s/SSH_PORT=\"generateport\"/SSH_PORT=\"$SSH_PORT\"/g" /root/userconfig.cfg

else
    if [[ $SSH_PORT =~ ^-?[0-9]+$ ]]; then

                if [[ -v BLOCKED_PORTS[$SSH_PORT] ]]; then
					echo "$SSH_PORT is known. Choose another SSH Port!"
					exit 1
				else
					#You can use this Port
					echo "${ok} Great, your SSH Port is: $SSH_PORT" | awk '{ print strftime("[%H:%M:%S] |"), $0 }'
				fi

            else
                echo "${error} SSH Port is not an integer, chose another one!" | awk '{ print strftime("[%H:%M:%S] |"), $0 }'
                exit 1
    fi
fi
#End Check SSH PORT


if [ ${USE_MAILSERVER} == '1' ]; then
  if [ ${MAILCOW_ADMIN_PASS} == 'generatepw' ]; then
	   MAILCOW_ADMIN_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')

		sed -i "s/MAILCOW_ADMIN_PASS=\"generatepw\"/MAILCOW_ADMIN_PASS=\"$MAILCOW_ADMIN_PASS\"/g" /root/userconfig.cfg
  fi
fi


if [ ${USE_PMA="1"} == '1' ]; then
  if [ ${PMA_HTTPAUTH_PASS} == 'generatepw' ]; then
	   PMA_HTTPAUTH_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')
  	 sed -i "s/PMA_HTTPAUTH_PASS=\"generatepw\"/PMA_HTTPAUTH_PASS=\"$PMA_HTTPAUTH_PASS\"/g" /root/userconfig.cfg
  fi
  
  if [ ${PMA_BFSECURE_PASS} == 'generatepw' ]; then
	   PMA_BFSECURE_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')
  	 sed -i "s/PMA_BFSECURE_PASS=\"generatepw\"/PMA_BFSECURE_PASS=\"$PMA_BFSECURE_PASS\"/g" /root/userconfig.cfg
  fi
fi

if [ ${MYSQL_ROOT_PASS} == 'generatepw' ]; then
	   MYSQL_ROOT_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')

  	 sed -i "s/MYSQL_ROOT_PASS=\"generatepw\"/MYSQL_ROOT_PASS=\"$MYSQL_ROOT_PASS\"/g" /root/userconfig.cfg
fi

if [ ${MYSQL_MCDB_PASS} == 'generatepw' ]; then
	   MYSQL_MCDB_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')
  	 sed -i "s/MYSQL_MCDB_PASS=\"generatepw\"/MYSQL_MCDB_PASS=\"$MYSQL_MCDB_PASS\"/g" /root/userconfig.cfg
fi

if [ ${MYSQL_RCDB_PASS} == 'generatepw' ]; then
	   MYSQL_RCDB_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')

  	 sed -i "s/MYSQL_RCDB_PASS=\"generatepw\"/MYSQL_RCDB_PASS=\"$MYSQL_RCDB_PASS\"/g" /root/userconfig.cfg
fi

if [ ${MYSQL_PMADB_PASS} == 'generatepw' ]; then
	   MYSQL_PMADB_PASS=$(openssl rand -base64 30 | tr -d / | cut -c -24 | grep -P '(?=^.{8,255}$)(?=^[^\s]*$)(?=.*\d)(?=.*[A-Z])(?=.*[a-z])')
  	 sed -i "s/MYSQL_PMADB_PASS=\"generatepw\"/MYSQL_PMADB_PASS=\"$MYSQL_PMADB_PASS\"/g" /root/userconfig.cfg
fi

}

source ~/userconfig.cfg
