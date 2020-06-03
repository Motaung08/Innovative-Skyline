<?php
 
include "conn.php";

 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
 
$ListID= $obj['ListID'];
$Title= $obj['Title'];

 $Sql_Query="UPDATE List SET List_Title='".$Title."' WHERE ListID='".$ListID."'";


 
//echo json_encode($Sql_Query);     


    if(mysqli_query($connect,$Sql_Query)){
    
         // If the record inserted successfully then show the message.
        $MSG = 'List updated successfully' ;
         
        // Converting the message into JSON format.
        $json = json_encode($MSG);
         
        // Echo the message.
         echo $json ;
    
    }

    else{
 
	 
	    $MSG = 'Try again.' ;
		$json = json_encode($CheckSQL);
		 
		// Echo the message.
		 echo $json ;
	 
	 
    }



mysqli_close($connect);
?>