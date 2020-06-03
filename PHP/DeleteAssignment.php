<?php

include "conn.php";

 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
$UserTypeID=$obj['UserTypeID'];
$AssignPerson=$obj['AssignPerson'];
$ProjectID=$obj['ProjectID'];

if($UserTypeID==1){
    $BoardQuery="DELETE FROM Assignment WHERE lower(StudentNo)='$AssignPerson' AND ProjectID='$ProjectID';";
}else{
    $BoardQuery="DELETE FROM Assignment WHERE lower(StaffNo)='$AssignPerson' AND ProjectID='$ProjectID';";
}



//echo json_encode($BoardQuery);

if($ProjectID!=null){
    if(mysqli_query($connect,$BoardQuery)){

    $MSG = 'Association DELETED!' ;
   
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
