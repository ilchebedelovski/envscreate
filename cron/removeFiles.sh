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

function remove {

	envid=$1
        envtype=$2
        envname=$3
        envpath=$4
        envdomain=$5
        envdbname=$6
        envversion=$7
        envprojectid=$8

	#echo $envid $envtype $envname $envpath $envdomain $envdbname $envversion $envprojectid

	#if [ -d $envpath ]; then
	$(rm -Rf $envpath)
	$($mysql -u $DBUSER -p$DBPASS -h $DBHOST -f drop $envdbname > )

	#else
	#echo "$envpath not found"
	#fi

}

# creating empty txt file
tmptextfile='forremove.txt'
`touch $tmptextfile`

# mysql query for selecting the not configured environments
$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "SELECT id, type, name, path, domain, dbname, version, project_id FROM envs_environments WHERE for_remove=1;" > $tmptextfile)

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

        remove $envid $envtype $envname $envpath $envdomain $envdbname $envversion $envprojectid

	$($mysql -u $DBUSER -p$DBPASS -h $DBHOST $DBNAME -Bse "UPDATE envs_project SET removed=1 WHERE id=$envprojectid;")
		
done

if [ -f $tmptextfile ]; then
        rm $tmptextfile
fi
