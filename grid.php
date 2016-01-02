<?php 

	require_once 'get.php';

	if(isset($_POST['data'])) {
		
		$data = $_POST['data'];
		$get = new get($data);		
		print_r($get->getEnvironment());
		
		
	}
	
	if(isset($_POST['elements'])) {
		$elements = $_POST['elements'];
		print_r($elements);
	}
	
	
	if(isset($_POST['data_sub'])) {
		
		$data = $_POST['data_sub'];
		$get = new get($data);		
		print_r($get->getSubEnvironment());
		
		
	}
	
	if(isset($_POST['subelements'])) {
		$subelements = $_POST['subelements'];
		print_r($subelements);
	}
	
	if(isset($_POST['remove'])) {
		$removeId = $_POST['id'];
		$get = new get();
		$get->removeEnvironment($removeId);
	}
	
?>