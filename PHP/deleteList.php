<?php

include "conn.php";

 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
$ListID=$obj['ListID'];

$ListQuery="DELETE FROM List WHERE ListID='$ListID';";

//echo json_encode($BoardQuery);

if(mysqli_query($connect,$ListQuery)){

    $MSG = 'List DELETED!' ;
   
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

    
 
mysqli_close($connect);
?>
