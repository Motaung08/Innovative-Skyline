<?php
include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);

 $AccessLevel=$obj['AccessLevelID'];
 $UserTypeID=$obj['UserTypeID'];
 $AssignPerson = $obj['AssignPerson'];
 $ProjectID = $obj['ProjectID'];

//  $AccessLevel='1';
//  $UserTypeID='1';
//  $AssignPerson ='1713445';
//  $ProjectID = '55';


if($UserTypeID=='1'){;
    
    $AssocQuery="INSERT INTO Assignment (ProjectID,StudentNo,AccessLevelID) VALUES('$ProjectID','$AssignPerson','$AccessLevel')";
    //echo json_encode($BoardQuery);
}
else{
    
    $AssocQuery="INSERT INTO Assignment (ProjectID,StaffNo,AccessLevelID) VALUES('$ProjectID','$AssignPerson','$AccessLevel')";
}


if(mysqli_query($connect,$AssocQuery)){
 $MSG = 'Association created!' ;

}
else{
    $MSG = 'Try Again. Possible connection failure.' ;
    if ($connect==true){
        $MSG = 'Connected but sql fail';
    }
   
}

 $json = json_encode($MSG);
    
    // Echo the message.
    echo $json ;
    
 
mysqli_close($connect);
?>
