<!DOCTYPE html>
	<html>
		<head>
			<title>gLogs - Install</title>

			<meta http-equiv="Content-Type" content="text/html; Charset=UTF-8">

			<link rel="stylesheet" href="../styles/default.css" type="text/css">
		</head>

		<body>
			<?
			require 'functions.php';

			// Form

			function step_1(){
				echo '<form method="post" action="index.php">
				<p class="big">&nbsp;</p>
				<table width="80%" border="0" align="center">
					<tr align="center" valign="middle" bgcolor="#FFFFFF">
						<th height="100" colspan="2" class="colhead">
							<p class="title big">Post install instructions:</p>
							<p class="title big">1) Create the database.</p>
							<p class="title big">2) Chmod the /include/secrets.php to 666 if using unix/linux</p>
						</th>
					</tr>
					<tr>
						<td colspan="2" class="colhead">Database Configuration</td>
					</tr>
					<tr>
						<td>Database Server (use localhost if not sure)</td>
						<td><input name="database_server" type="text" id="database_server" placeholder="Database Server" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Database Name</td>
						<td><input name="database_name" type="text" id="database_name" placeholder="Database Name" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Database User</td>
						<td><input name="database_user" type="text" id="database_user" placeholder="Database User" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Database Password</td>
						<td><input name="database_password" type="text" id="database_password" placeholder="Database Password" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td colspan="2" class="colhead">Super Admin Configuration</td>
					</tr>
					<tr>
						<td>Sysop Username</td>
						<td><input name="super_admin_name" type="text" id="super_admin_name" placeholder="Super-Admin Name" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Sysop Password</td>
						<td><input name="super_admin_password" type="text" id="super_admin_password" placeholder="Super-Admin Password" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Sysop Password Confirm</td>
						<td><input name="super_admin_pass2" type="text" id="super_admin_pass2" placeholder="Super-Admin Password Confirm" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Sysop Email</td>
						<td><input name="super_admin_mail" type="text" id="super_admin_mail" placeholder="Super-Admin E-Mail" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td colspan="2" class="colhead">Basic Site Configuration</td>
					</tr>
					<tr>
						<td>Site Name</td>
						<td><input name="sitename" type="text" id="sitename" placeholder="Site Name" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Domain (no ending slash)</td>
						<td><input name="domain" type="text" id="domain" placeholder="Domain" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Site Email Address</td>
						<td><input name="siteemail" type="text" id="siteemail" placeholder="Site E-Mail" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td>Key Registrar</td>
						<td><input name="siteemail" type="text" id="siteemail" placeholder="rvERvqz56zTsGR5" size="40" maxlength="40"></td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								<input name="install" type="submit" class="red" placeholder="Install">
							</div>
						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
			</form>
		</body>
	</html>
';
			}
			
			include('../include/secrets.php');

			if (defined("GLOGS_INSTALLED")){
				die('<center><h1><a href="../index.php">Already installed please return to the index</a></h1></center>');
				exit;
			}

			if (isset($_POST['install'])){
				if( $_POST['install'] || $_GET['install']){
					update_config();
					basic_query();
					insert_sysop();
					config();
					finale();
				}
			}
			else{
				step_1();
			}
		?>
