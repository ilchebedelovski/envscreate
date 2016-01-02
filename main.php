<head>
	<style>
	<?php include 'style.css'; ?>
	</style>
</head>
<body class="sucess-page">
	<?php 


	require_once 'create.php';
	//require_once 'grid.php';
	
	if(isset($_POST['data'])) {
	
		$data = $_POST['data'];
		
		$create = new create($data);
		$names = $create->envNameCheck();
		
		// Checking if the requested name is busy
		if (!in_array($data['input-ext-name'], $names)) {
			$domains = $create->dbInsert();	
			echo "<div class='message'>You've made successfull request for the following domains: " . "</div>";
			foreach ($domains as $domain) {
				echo '<div class="domains">'.$domain ."</div>";
			}
			echo '<div class="env-details">You will receive an email with the environment details</div>';
			echo '<div class="go-back-button"><a href="http://envsmanager.ecomwisedev.com">Go Back</a></div>';
		}
		else {
			echo "<div class='notification-message'>The requested extension name is already used. Please try with another name.</div>";
			echo '<div class="go-back-button"><a href="http://envsmanager.ecomwisedev.com">Go Back</a></div>';
		}

	}
	else {
		echo "<div class='reguired-message'>Please type all required input</div>";
	}
	

?>
</body>