<?php

include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
$ProjectID=$obj['ProjectID'];
$List_Title = $obj['List_Title'];

// $ProjectID='103';
// $List_Title = "abc new";



$ListQuery="INSERT INTO List (ProjectID, List_Title) VALUES('$ProjectID','$List_Title');";

$testOut=json_encode($ListQuery);
//echo $testOut;
    
    if(mysqli_query($connect,$ListQuery)){

        $MSG = 'List created!' ;   
        
             // Converting the message into JSON format.
            $json = json_encode($MSG);
            
            // Echo the message.
            echo $json ;
        

    }
    else{
        $MSG = 'Try Again' ;
        if ($connect==true){
            $MSG = 'Connected but sql fail';
        }
        $json = json_encode($MSG);
    
        // Echo the message.
        echo $json ;
    }
    
 
//mysqli_close($connect);
?>