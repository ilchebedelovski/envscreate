<?php

	require '../db.php';
	
	$db = new db();
	$connection = $db->connection();
	mysql_select_db($db::DBNAME);
	
	$sql = "SELECT envs_environments.type, envs_environments.path, envs_environments.domain, envs_environments.dbname, envs_environments.version, envs_config.db_host, envs_config.db_user, envs_config.db_pass, envs_config.db_name, envs_config.src_path 
						FROM envs_environments 
						LEFT JOIN envs_config ON envs_config.id=envs_environments.config_id 
						WHERE envs_environments.is_created=0";
	
	$result = mysql_query($sql, $connection);
	
	if (!$result) {
		echo 'Could not run query: ' . mysql_error();
		exit;
	}
	
	while ($row = mysql_fetch_row($result)) {
			
		$envType = $row[0];
		$envPath = $row[1];
		$envDomain = $row[2];
		$envDbname = $row[3];
		$envVersion = $row[4];
		$dbHost = $row[5];
		$dbUser = $row[6];
		$dbPass = $row[7];
		$dbName = $row[8];
		$srcPath = $row[9];
		
		system('bash createFiles.sh envtype__' . $envType . ' envpath__' . $envPath . ' envdbname__' . $envDbname . ' envdomain__' . $envDomain . ' envversion__' . $envVersion . ' dbhost__' . $dbHost . ' dbuser__' . $dbUser . ' dbpass__' . $dbPass . ' dbname__' . $dbName . ' srcpath__' . $srcPath, $return);
	
	}

?>