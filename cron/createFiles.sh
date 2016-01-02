#!/bin/bash

STARTDATE=$(date +"%Y-%m-%d")
mysql=`which mysql`
xmllint=`which xmllint`
mail=`which mail`

DBHOST=`echo 'cat //envsmanager/dbenvs/dbhost/text()' | xmllint --shell  ../config.xml | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`
DBUSER=`echo 'cat //envsmanager/dbenvs/dbuser/text()' | xmllint --shell  ../config.xml | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`
DBPASS=`echo 'cat //envsmanager/dbenvs/dbpass/text()' | xmllint --shell  ../config.xml | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`
DBNAME=`echo 'cat //envsmanager/dbenvs/dbname/text()' | xmllint --shell  ../config.xml | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`
SRCPATH=`echo 'cat //envsmanager/filesystemenvs/srcpath/text()' | xmllint --shell  ../config.xml | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`
CONFPATH=`echo 'cat //envsmanager/apache/confpath/text()' | xmllint --shell  ../config.xml | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`

#echo "$DBHOST $DBUSER $DBPASS $DBNAME $SRCPATH"

function create {

	envid=$1
	envtype=$2
	envname=$3
        envpath=$4
        envdomain=$5
	envdbname=$6
        envversion=$7
	envprojectid=$8

	if [[ "$envtype" == "development" || "$envtype" == "test"  ]]; then

		mageversion=${envversion##*-}
		magesrcpath=$SRCPATH"/"$mageversion
		magedstpath=$envpath"/"$envversion

		if [ -d $magesrcpath ]; then
			createFiles $magedstpath $magesrcpath $envdbname
			echo "Filesystem created for $envdomain"
		else
			echo "The source environment is not available"
		fi

		databases=$($mysql -u $DBUSER -p$DBPASS -h $DBHOST -Bse "SHOW DATABASES")
		dbelements=${#databases[@]}
		for (( i=0;i<$dbelements;i++ )); do
			if [[ ${databases[${i}]} == "$envdbname" ]]; then
				echo "Database exists"
			else
				createEnvDb $magedstpath $envdomain $envdbname
				echo "Db created for $envdomain"
			fi
		done

		if [ -d $CONFPATH ]; then
			vhostpath=$CONFPATH"man_$envname.conf"
			if [ ! -f $vhostpath ]; then
				`touch $vhostpath`
				createVirtualHost $vhostpath $magedstpath $envdomain
			else
				createVirtualHost $vhostpath $magedstpath $envdomain
			fi
		fi

	elif [ "$envtype" == "github" ];then
		$(mkdir -p $envpath)	
	else
		echo "Environment type is unknown"
	fi
	
	# updating the creation status
	$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "UPDATE envs_environments SET is_created=1 WHERE id=$envid;")

}

function createFiles {

	magedstpath=$1
	magesrcpath=$2
	magedbname=$3
	magelocalxml="$magedstpath/app/etc/local.xml"

	$(mkdir -p $magedstpath)
        $(chmod 755 -R $magedstpath)
        $(cp -af $magesrcpath'/.' $magedstpath)
	$(find $magedstpath -type d | xargs chmod 755)
	$(find $magedstpath -type f | xargs chmod 644)
	$(chmod 777 -R "$magedstpath/var")
	$(chmod 777 -R "$magedstpath/media")

	if [ -f $magelocalxml ]; then
		`sed -i "s/replacedatabase/$magedbname/g" $magelocalxml`
	else
		echo "local.xml is not available"
	fi

}

function createEnvDb {

	envSql=$1"/cleanmagento.sql"
	envDomain="http://$2/"
	envDbname=$3
	
	if [ -f $envSql ]; then
		$($mysql -u $DBUSER -p$DBPASS -h $DBHOST -Bse "CREATE DATABASE $envDbname DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;")
		$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $envDbname < $envSql)
		$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $envDbname -Bse "UPDATE core_config_data SET value='$envDomain' WHERE path='web/unsecure/base_url';") 
		$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $envDbname -Bse "UPDATE core_config_data SET value='$envDomain' WHERE path='web/secure/base_url';")
	else
		echo "The source sql file do not exists"
	fi

}

function createVirtualHost {
	vhostconf=$1
	dstpath=$2
	domain=$3

        echo "<VirtualHost *:80>" >> $vhostconf
        echo -e "\tDocumentRoot "$dstpath >> $vhostconf
        echo -e "\tServerName "$domain >> $vhostconf
	echo -e "\t<Directory '"$dstpath"'>" >> $vhostconf
	echo -e         "\t\tAllowOverride All"  >> $vhostconf
	echo -e         "\t\tOptions None" >> $vhostconf
	echo -e         "\t\tOrder allow,deny" >> $vhostconf
	echo -e         "\t\tAllow from all" >> $vhostconf
	echo -e "\t</Directory>" >> $vhostconf
	echo "</VirtualHost>" >> $vhostconf
	echo -e "\t" >> $vhostconf	
}

function sendEmail {
	args=("$@")
	domain=()
	for i in ${args[@]}; do
		[[ ${i%%__*} == 'usremail' ]] && local email=${i##*__}
		[[ ${i%%__*} == 'usrenv' ]] && local env=${i##*__}
		[[ ${i%%__*} == 'usrdomains' ]] && local domain+=`echo "${i##*__} "`
		[[ ${i%%__*} == 'usrpath' ]] && local path=${i##*__}
	done
	text=$(echo -e "The following domains are created for you: \n\n $domain \n\n Environments path: $path \n\nLogin details for backend: \n Username: admin \n Password: test123")
	echo "$text" | $mail -s "$env is created" $email
}

# creating empty txt file
tmptextfile='forinstall.txt'
`touch $tmptextfile`

# mysql query for selecting the not configured environments
$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "SELECT id, type, name, path, domain, dbname, version, project_id FROM envs_environments WHERE is_created=0;" > $tmptextfile)

declare -a emailIds=()
touch 'foremail.txt'

cat $tmptextfile | while read line; do
        input=( $line )
	envid=${input[0]}
        envtype=${input[1]}
	envname=${input[2]}
        envpath=${input[3]}
        envdomain=${input[4]}
	envdbname=${input[5]}
        envversion=${input[6]}
	envprojectid=${input[7]}
	
        create $envid $envtype $envname $envpath $envdomain $envdbname $envversion $envprojectid	

	emailIds+=( $envprojectid )
	echo '' > 'foremail.txt'
	echo ${emailIds[@]} > 'foremail.txt'
done

# get ids from file into array and send email for every id
emailIds=( `cat 'foremail.txt'` )
sortedEmailIds=`echo "${emailIds[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '`
for i in ${sortedEmailIds[@]}; do
	userEmailSent=$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "SELECT is_email_sent FROM envs_project WHERE id=$i;")
	if [[ $userEmailSent == 0 ]]; then
		userEmail=$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "SELECT user_email FROM envs_project WHERE id=$i")
		userEnv=$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "SELECT name FROM envs_project WHERE id=$i")
		usrPath=$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "SELECT path FROM envs_project WHERE id=$i")
		userDomains=$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "SELECT domain FROM envs_environments WHERE project_id=$i AND type IN ('development', 'test');")
		emailArgs=( "usremail__$userEmail" "usrenv__$userEnv" "usrpath__$usrPath" )
		for domain in ${userDomains[@]}; do
			emailArgs+=( "usrdomains__$domain" )
		done
		sendEmail ${emailArgs[@]}
		$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "UPDATE envs_project SET is_email_sent='1' WHERE id=$i;")
		/usr/bin/sudo /usr/sbin/apachectl -k graceful
	fi
done

# removing txt files
if [ -f 'foremail.txt' ]; then
	rm 'foremail.txt'
fi
if [ -f $tmptextfile ]; then
	rm $tmptextfile
fi
