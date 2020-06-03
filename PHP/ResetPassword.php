<?php

include "conn.php";

$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$Email = $obj['Email'];
$Password= $obj['Password'];

$CheckSQL = "SELECT * FROM User WHERE lower(Email)='".$Email."'";

$check = mysqli_fetch_array(mysqli_query($connect,$CheckSQL));

if(isset($check)){
	 
	 $hash= password_hash($Password,PASSWORD_DEFAULT);
	 $Sql_Query="UPDATE User SET User.Password='".$hash."' WHERE lower(User.Email)='".$Email."'";
	 
	 
	 if(mysqli_query($connect,$Sql_Query)){
		$MSG = 'Password updated successfully' ;
		$json = json_encode($MSG);
		 echo $json ;
	 }
	 	 $MSG = 'Email Exists but password not reset.';
 
} else{
	    $MSG = 'No user found.' ;
		$json = json_encode($MSG);
		 echo $json ;
 }
 mysqli_close($connect);
?>