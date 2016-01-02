<?php 

	require 'db.php';
	
	class Get {
	
		public function getEnvironment() {
				
			$db = new db();
			$connection = $db->connection();
			mysql_select_db($db::DBNAME);
			
			$sqlGetProjects = "SELECT id, name, domain, user_email FROM envs_project WHERE removed=0";
			$queryGetProjects = mysql_query($sqlGetProjects, $connection);
			$arrayGetProjects = array();
			
			while ($row = mysql_fetch_array($queryGetProjects, MYSQL_ASSOC)) {
				$arrayGetProjects[] = $row;
			}
				
			return json_encode(array("elements" => $arrayGetProjects));
		}
	   public function getSubEnvironment() {
				
			$db = new db();
			$connection = $db->connection();
			mysql_select_db($db::DBNAME);
			
			$sqlGetSubProjects = "SELECT id, name, domain FROM envs_environments WHERE for_remove=0";
			$queryGetSubProjects = mysql_query($sqlGetSubProjects, $connection);
			$arrayGetSubProjects = array();
			
			while ($row = mysql_fetch_array($queryGetSubProjects, MYSQL_ASSOC)) {
				$arrayGetSubProjects[] = $row;
			}
				
			return json_encode(array("subelements" => $arrayGetSubProjects));
		}
	
		public function removeEnvironment($removeId) {
				
			$db = new db();
			$connection = $db->connection();
			mysql_select_db($db::DBNAME);
			
			$sqlUpdateEnvs = "UPDATE envs_environments SET for_remove=1 WHERE project_id=" . $removeId . ";";
			$queryUpdateEnvs = mysql_query($sqlUpdateEnvs, $connection);
			
			if(!$queryUpdateEnvs) {
				return json_encode(array('error' => die('Could not enter data: ' . mysql_error())));
			}
			
			/*
			
			$sqlSelectEnvs = "SELECT name, path, dbname FROM envs_environments WHERE project_id=" . $removeId . ";";
			$querySelectEnvs = mysql_query($sqlSelectEnvs, $connection);
			$arraySelectEnvs = array();
			
			while ($envsRow = mysql_fetch_array($querySelectEnvs, MYSQLI_ASSOC)) {
				//$arraySelectEnvs[] = ('name' => $envsRow['name'], 'path' => $envsRow['path'], 'dbname' => $envsRow['dbname']);
				$arraySelectEnvs[] = $envsRow;
			}
			
			
			
			print_r($arraySelectEnvs);
			*/
			//return json_encode(array('return' => $arraySelectEnvs ));
			
			/*	
			$sqlRemoveProject = "DELETE FROM envs_project WHERE id=" . $removeId . ";";
			$queryRemoveProject = mysql_query($sqlRemoveProject, $connection);
			
			if(!$queryRemoveProject) {
				return json_encode(array('error' => die('Could not enter data: ' . mysql_error())));
			}
			*/
			
		}
	
	}



?>