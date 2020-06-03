<?php
 
include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
// Getting name from $obj object.
//$name = $obj['name'];
 
// Getting Email from $obj object.
$email = $obj['email'];
//$email='admin';
 
// Getting Password from $obj object.
$password = $obj['password'];
//$password='123456';

//Getting user type from object
$userType=$obj['userType'];
//$userType='1';

// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckSQL = "SELECT * FROM User WHERE lower(Email)='$email'";
 
// Executing Email Check MySQL Query.
$check = mysqli_fetch_array(mysqli_query($connect,$CheckSQL));
 
 
if(isset($check)){
 
	 $emailExist = 'Email Already Exists, Please Try Again With New Email Address..!';
	 
	 // Converting the message into JSON format.
	$existEmailJSON = json_encode($emailExist);
	 
	// Echo the message on Screen.
	 echo $existEmailJSON ; 
 
  }
 else{
     $hash=password_hash($password,PASSWORD_DEFAULT);
 
	 // Creating SQL query and insert the record into MySQL database table.
 	 $Sql_Query = "INSERT INTO User (UserID, Email, Password, UserTypeId) VALUES (NULL, '$email', '$hash', '$userType')";

	 if(mysqli_query($connect,$Sql_Query)){
	 
		 // If the record inserted successfully then show the message.
		$MSG = 'User Registered Successfully' ;
		 
		// Converting the message into JSON format.
		$json = json_encode($MSG);
		 
		// Echo the message.
		 echo $json ;
	 
	 }
	 else{
	 
		echo 'Try Again';
	 
	 }
 }
 mysqli_close($connect);
?>