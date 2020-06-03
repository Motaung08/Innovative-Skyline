<?php
 
include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
 
// Getting Email from $obj object.
$email = $obj['email'];
 
// Getting student number from $obj object.
$StudentNo = $obj['StudentNo'];

//Getting first name from object
$Student_FName=$obj['Student_FName'];

//Getting last name from object
$Student_LName=$obj['Student_LName'];

//Getting Degree Type from object
$DegreeType=$obj['DegreeType'];

//Getting Registration Date from object
$RegistrationDate=$obj['RegistrationDate'];

//Getting Full/Part time from object
$StudentTypeID=$obj['StudentTypeID'];


//---

// // Getting Email from $obj object.
// $email = 'testStudent@students.wits.ac.za';
 
// // Getting student number from $obj object.
// $StudentNo = "UniqueStudNo123";

// //Getting first name from object
// $Student_FName="Test";

// //Getting last name from object
// $Student_LName="Student";

// //Getting Degree Type from object
// $DegreeType='1';

// //Getting Registration Date from object
// $RegistrationDate='2020-05-31';

// //Getting Full/Part time from object
// $StudentTypeID='1';

//---
 
// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckEmailSQL = "SELECT * FROM Students WHERE lower(Student_Email)='$email'";
 
// Executing Email Check MySQL Query.
$checkEmail = mysqli_fetch_array(mysqli_query($connect,$CheckEmailSQL));

// Checking whether StudentNo is Already Exist or Not in MySQL Table.
$CheckStudentSQL = "SELECT * FROM Students WHERE lower(StudentNo)='$StudentNo'";
 
// Executing Email Check MySQL Query.
$checkStudent = mysqli_fetch_array(mysqli_query($connect,$CheckStudentSQL));
 
 
if(isset($checkEmail)){
 
	 $emailExist = 'Email Already Exist, Please Try Again With New Email Address..!';
	 
	 // Converting the message into JSON format.
	$existEmailJSON = json_encode($emailExist);
	 
	// Echo the message on Screen.
	 echo $existEmailJSON ; 
 
  }
 else{
     
     if(isset($checkStudent)){
         $studentExist = 'An account has already been created for this student number.';
         $existsStudentJSON = json_encode($studentExist);
         echo $existsStudentJSON;
     }
     else
     {
         // Creating SQL query and insert the record into MySQL database table.
      	 $Sql_Query = "INSERT INTO Students (StudentNo, Student_FirstName, Student_LastName, Student_Email, Degree_ID, Student_RegistrationDate, StudentTypeID) VALUES ('$StudentNo','$Student_FName','$Student_LName','$email','$DegreeType','$RegistrationDate', '$StudentTypeID')";
    
    
    	 if(mysqli_query($connect,$Sql_Query)){
    	 
    		 // If the record inserted successfully then show the message.
    		$MSG = 'Student Registered Successfully' ;
    		 
    		// Converting the message into JSON format.
    		$json = json_encode($MSG);
    		 
    		// Echo the message.
    		 echo $json ;
    	 
    	 }
    	 else{
    	    $MSG = 'Try Again' ;
    	    
    		
    		if($connect==true){
    		    $MSG = 'Connected but SQL fail -Try Again' . $Sql_Query ;
    		}
    		 $json = json_encode($MSG);
    		// Echo the message.
    		 echo $json ;
    	 
    	 }
    }
 
	 
 }
 mysqli_close($connect);
?>