<?php

include "conn.php";

 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
$TaskID=$obj['TaskID'];

$BoardQuery="DELETE FROM Task WHERE TaskID='$TaskID';";

//echo json_encode($BoardQuery);

if($TaskID!=null){
    if(mysqli_query($connect,$BoardQuery)){

    $MSG = 'Task DELETED!' ;
   
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
}else{
    $MSG='Task ID is null!';
    $json = json_encode($MSG);
        
        // Echo the message.
        echo $json ;
}

    
 
mysqli_close($connect);
?>
