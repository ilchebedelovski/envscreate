<?php 

	class Db {

		const DBNAME = 'utl_envsmanager_1507161505';
		
		public function connection() {
			return mysql_connect('192.168.1.102', 'root', '');
		}
		
	}

?>