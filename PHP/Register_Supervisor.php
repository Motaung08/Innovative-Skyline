<?php
 
include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
// Getting Email from $obj object.
$email = $obj['email'];
 
// Getting student number from $obj object.
$StaffNo = $obj['StaffNo'];

//Getting first name from object
$Sup_FName=$obj['Sup_FName'];

//Getting last name from object
$Sup_LName=$obj['Sup_LName'];

//Getting Degree Type from object
$Supervisor_OfficePhone=$obj['Supervisor_OfficePhone'];

 
// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckSQL = "SELECT * FROM Supervisor WHERE lower(Supervisor_Email)='$email'";
 
// Executing Email Check MySQL Query.
$check = mysqli_fetch_array(mysqli_query($connect,$CheckSQL));

// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckSupSQL = "SELECT * FROM Supervisor WHERE lower(StaffNo)='$StaffNo'";
 
// Executing Email Check MySQL Query.
$checkSup = mysqli_fetch_array(mysqli_query($connect,$CheckSupSQL));
 
 
if(isset($check)){
 
	 $emailExist = 'Email Already Exists, Please Try Again With New Email Address..!';
	 
	 // Converting the message into JSON format.
	$existEmailJSON = json_encode(strip_tags($emailExist));
	 
	// Echo the message on Screen.
	 echo $existEmailJSON ; 
 
  }
 else{
 
	 if(isset($checkSup)){
	     $supExist = 'This staff number already has an associated account.';
	 
	 // Converting the message into JSON format.
	$existSupJSON = json_encode($supExist);
	 
	// Echo the message on Screen.
	 echo $existSupJSON ; 
	 }
	 else{
	     // Creating SQL query and insert the record into MySQL database table.
 	 $Sql_Query = "INSERT INTO Supervisor (StaffNo, Supervisor_Firstname, Supervisor_Lastname, Supervisor_Email, Supervisor_OfficePhone) VALUES ('$StaffNo','$Sup_FName','$Sup_LName','$email','$Supervisor_OfficePhone')";
 	 // 
 	 // ('1713445','Meghan','SB','MegSB@gmail.com','+27')";

	 if(mysqli_query($connect,$Sql_Query)){
	 
		 // If the record inserted successfully then show the message.
		$MSG = 'Supervisor Registered Successfully' ;
		 
		// Converting the message into JSON format.
		$json = json_encode($MSG);
		 
		// Echo the message.
		 echo $json ;
	 
	 }
	 else{
	    $MSG = 'Try Again' ;
		$json = json_encode($MSG);
		 
		// Echo the message.
		 echo $json ;
	 
	 }
	 }
 }
 mysqli_close($con);
?>