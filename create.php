<?php 

	require 'db.php';

	class Create {
		
		protected $extensionName = null;
		protected $useDemoData = null;
		protected $userEmail = null;
		protected $includedDev = array();
		protected $includedTest = array();
		protected $includedGithub = null;
		protected $projectPath = '/var/www/html/environments/manualenvs';
		
		public function __construct($data) {
			
			if(isset($data)) {
			
				foreach ($data as $key=>$value) {
					
					if (0 === strpos($key, 'input-dev')) {
	   					$this->includedDev[] = $value;
					}
					
					if (0 === strpos($key, 'input-test')) {
						$this->includedTest[] = $value;
					}
					
				}
				
				$this->extensionName = $data['input-ext-name'];
				$this->useDemoData = $data['input-usedemodata'];
				$this->userEmail = $data['input-emailaddr'];
				if(isset($data['input-github-incl'])) {
					$this->includedGithub = $data['input-github-incl'];
				}
			
			}
			
		}
		
		public function dbInsert() {
			
			$db = new db();
			$connection = $db->connection();
			mysql_select_db($db::DBNAME);
			
			$envName = $this->extensionName;
			$envDomain = 'www.' . $this->extensionName . '.ecomwisedev.com';
			$envDomainsArray = array();
			$envPath = $this->projectPath . '/' . $this->extensionName;
			$envDevArray = array();
			$envTesetArray = array();
			$userEmail = $this->userEmail;
			$configId = 1;

			if(is_array($this->includedDev)) {
				$envDevelopment = 1;
			}
			
			if(is_array($this->includedTest)) {
				$envTest = 1;
			}
			
			if(isset($this->includedGithub)) {
				$envGithub = 1;
			}
			else {
				$envGithub = 0;
			}

			$sqlProject = "INSERT INTO envs_project (name, path, domain, user_email, development, test, github) VALUES ('" . $envName . "', '" . $envPath . "', '" . $envDomain . "', '" . $userEmail . "', '" . $envDevelopment . "', '" . $envTest . "', '" . $envGithub . "')";
			$queryProject = mysql_query($sqlProject, $connection);
			
			if(! $queryProject )
			{
				die('Could not enter data: ' . mysql_error());
			}
			
			$envId = mysql_insert_id();
			
			if($envDevelopment == 1) {
				foreach ($this->includedDev as $value) {
					
					$dateNow = date("ymdHi");
					$envVersionDev = $value;
					$envNameDev = preg_replace('~[^a-z0-9]+~', '', $value);
					$envDomainDev = $envNameDev . '.' . $envName . '.ecomwisedev.com';
					$envDbnameDev = 'man_' . $envNameDev . '_' . $dateNow;
					$envDomainsArray[] = $envDomainDev;
					
					$sqlEnvironments = "INSERT INTO envs_environments (type, name, path, domain, dbname, version, project_id, config_id) VALUES ('development', '" . $envName . "', '" . $envPath . "', '" . $envDomainDev . "', '" . $envDbnameDev . "', '" . $envVersionDev . "', '" . $envId . "', '" . $configId . "')";;
					$queryEnvironments = mysql_query($sqlEnvironments, $connection);
					
					if(! $queryEnvironments )
					{
						die('Could not enter data: ' . mysql_error());
					}
					
				}
			}
			
			if($envTest == 1) {
				foreach ($this->includedTest as $value) {
											
					$dateNow = date("ymdHi");
					$envVersionTest = $value;
					$envNameTest = preg_replace('~[^a-z0-9]+~', '', $value);
					$envDomainTest = $envNameTest . '.' . $envName . '.ecomwisedev.com';
					$envDbnameTest = 'man_' . $envNameTest . '_' . $dateNow;
					$envDomainsArray[] = $envDomainTest;
					
					$sqlEnvironments = "INSERT INTO envs_environments (type, name, path, domain, dbname, version, project_id, config_id) VALUES ('test', '" . $envName . "', '" . $envPath . "', '" . $envDomainTest . "', '" . $envDbnameTest . "', '" . $envVersionTest . "', '" . $envId . "', '" . $configId . "')";;
					$queryEnvironments = mysql_query($sqlEnvironments, $connection);
					
					if(! $queryEnvironments )
					{
						die('Could not enter data: ' . mysql_error());
					}
						
				}
			}
			
			if($envGithub == 1) {

				$envDirName = 'github-' . strtolower($envName);
				$envPathGithub = $envPath . '/' . $envDirName;
				
				$sqlEnvironments = "INSERT INTO envs_environments (type, name, path, domain, dbname, version, project_id) VALUES ('github', '" . $envName . "', '" . $envPathGithub . "', '', '', '', '" . $envId . "')";;
				$queryEnvironments = mysql_query($sqlEnvironments, $connection);
				
				if(! $queryEnvironments )
				{
					die('Could not enter data: ' . mysql_error());
				}
			}
			
			mysql_close($connection);
						
			return $envDomainsArray;

		}
		
		public function envNameCheck() {
			
			$db = new db();
			$connection = $db->connection();
			mysql_select_db($db::DBNAME);
			
			$sqlGetName = "SELECT name FROM envs_project";
			$queryGetName = mysql_query($sqlGetName, $connection);
			$arrayGetName = array();
			
			while ($row = mysql_fetch_array($queryGetName, MYSQL_ASSOC)) {
				$arrayGetName[] = $row['name'];
			}
			
			mysql_close($connection);
			
			return $arrayGetName;
			
		}
	
		
	}

?>