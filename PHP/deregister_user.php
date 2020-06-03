<?php
 
include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
 
// Getting Email from $obj object.
$email = $obj['email'];
//$email='admin';
 

//Getting user type from object
$userType=$obj['userType'];
//$userType='1';

// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckSQL = "SELECT * FROM User WHERE lower(Email)='$email'";
 
// Executing Email Check MySQL Query.
$check = mysqli_fetch_array(mysqli_query($connect,$CheckSQL));
 
 
if(empty($check)){
 
	 $emailExist = 'No such user exists!';
	 
	 // Converting the message into JSON format.
	$existEmailJSON = json_encode($emailExist);
	 
	// Echo the message on Screen.
	 echo $existEmailJSON ; 
 
  }
 else{

 
	 // Creating SQL query and insert the record into MySQL database table.
 	 $Sql_Query = "DELETE FROM User WHERE lower(Email)='$email'";

	 if(mysqli_query($connect,$Sql_Query)){
	 
		 // If the record inserted successfully then show the message.
		$MSG = 'User DeRegistered Successfully but not SubUser' ;
		if($userType==1){
		    $Sql_Student_Query = "DELETE FROM Students WHERE lower(Student_Email)='$email'";
		    if(mysqli_query($connect,$Sql_Student_Query)){
		        $MSG="Student removed successfully.";
		    }
		}else{
		    $Sql_Supervisor_Query = "DELETE FROM Supervisor WHERE lower(Supervisor_Email)='$email'";
		    if(mysqli_query($connect,$Sql_Supervisor_Query)){
		        $MSG="Supervisor removed successfully.";
		    }
		}

	 
	 }
	 else{
	 
		$MSG='Try Again';
	 
	 }
 }
 // Converting the message into JSON format.
		$json = json_encode($MSG);
		 
		// Echo the message.
		 echo $json ;
 mysqli_close($connect);
?>