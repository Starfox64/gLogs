<?php
	error_reporting(E_ALL ^ E_NOTICE);

	function update_config(){
		$config_data = '<?php'."\n\n";
		$config_data .= '	//// This file was created automaticly                          ////' . "\n";
		$config_data .= '	//// please do not remove the lines                             ////' . "\n";
		$config_data .= '	//// if you want to re-install please remove all the lines      ////' . "\n\n";
		$config_data .= '	$mysql_host = \'' . $_POST['database_server'] . '\';            //// The Database Host          ////' . "\n";
		$config_data .= '	$mysql_dbname = \'' . $_POST['database_name'] . '\';            //// The Database Name          ////' . "\n";
		$config_data .= '	$mysql_user = \'' . $_POST['database_user'] . '\';              //// The Database User          ////' . "\n";
		$config_data .= '	$mysql_pass = \'' . $_POST['database_password'] . '\';          //// The Database Password      ////' . "\n\n";
		$config_data .= '	$super_admin_name = \'' . $_POST['super_admin_user'] . '\';     //// The Super Admin Name       ////' . "\n";
		$config_data .= '	$super_admin_pass = \'' . $_POST['super_admin_pass'] . '\';     //// The Super Admin Password   ////' . "\n";
		$config_data .= '	define(\'GLOGS_INSTALLED\', true);'."\n";
		$config_data .= '?' . '>';

		// Done this to prevent highlighting editors getting confused!

		if (!($fp = fopen('../include/secrets.php', 'w'))){
			die("Make 'secrets.php' writable -> 666");
		}
		
		else{
			$result = @fputs($fp, $config_data, strlen($config_data));
			@fclose($fp);
		}

		if (!mysql_connect($_POST['server'],$_POST['dbuser'],$_POST['dbpass'])){
			die('Cant connect to databaseserver');
		}
		
		if (!mysql_select_db($_POST['dbname'])){
			die('Cant select database');
		}
	}

	function basic_query(){
		include('../include/secrets.php');

		if (!mysql_connect($mysql_host,$mysql_user,$mysql_pass)){
			die('Cant connect to databaseserver');
		}
		
		if (!mysql_select_db($mysql_db)){
			die('Cant select database');
		}
	}
	
	function insert_super_admin(){
		if($_POST['super_admin_pass'] != $_POST['super_admin_pass2']){
			die('Error : The Super Admin passwords do not match!');
		}
		
		$username = $_POST['super_admin_name'];
		$usermail = $_POST['super_admin_mail'];
		
		$secret = mksecret();
		$wantpasshash = md5($secret . $_POST['super_admin_pass'] . $secret);
		$editsecret = mksecret();
		
		$ret = mysql_query("INSERT INTO users (username, class, passhash, secret, editsecret, email, status, added) VALUES (" .	implode(",", array_map("sqlesc", array($username, 6, $wantpasshash, $secret, $editsecret, $usermail, 'confirmed'))) . ",'" . get_date_time() . "')");
	}

	function config(){
		$online = gmdate("Y-m-d");
		$added = sqlesc(get_date_time());
		
		mysql_query("INSERT INTO config (name,value) VALUES ('siteonline','true')");
		mysql_query("INSERT INTO config (name,value) VALUES ('onlinesince','$online')");
		mysql_query("INSERT INTO config (name,value) VALUES ('sitename','".$_POST['sitename']."')");
		mysql_query("INSERT INTO config (name,value) VALUES ('domain','".$_POST['domain']."')");
		mysql_query("INSERT INTO config (name,value) VALUES ('sitemail','".$_POST['sitemail']."')");
	}
	
	function finale(){
		echo 'Install Finished<br />
			Please remove the install directory or use chmod to make it non-accessible<br />
			You may login<br />
			<a href="../index.php">HERE</a>
		';
	}
  
	function mksecret($len = 20){
		$ret = "";
		for ($i = 0; $i < $len; $i++)
			$ret .= chr(mt_rand(0, 255));
		return $ret;
	}

	function get_date_time($timestamp = 0){
		if ($timestamp)
			return date("Y-m-d H:i:s", $timestamp);
		else
			return gmdate("Y-m-d H:i:s");
	}

	function sqlesc($x){
		return "'" . mysql_real_escape_string($x) . "'";
	}
?>
