<?php
include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);


 $UserTypeID=$obj['UserTypeID'];
 $AssignPerson = $obj['AssignPerson'];
 $ProjectID = $obj['ProjectID'];


//  $UserTypeID='1';
//  $AssignPerson ='1713445';
//  $ProjectID = '55';


if($UserTypeID=='1'){;
    
    $AssocQuery="SELECT * FROM Assignment WHERE lower(StudentNo)='$AssignPerson' AND ProjectID='$ProjectID'";
    //echo json_encode($BoardQuery);
}
else{
    
    $AssocQuery="SELECT * FROM Assignment WHERE lower(StaffNo)='$AssignPerson' AND ProjectID='$ProjectID'";
}



if(mysqli_query($connect,$AssocQuery)){
 $MSG = 'Association found!' ;
     $queryResult=$connect->query($AssocQuery);
    
    $result=array();
    
    while($fetchData=$queryResult->fetch_assoc()){
        $result[]=$fetchData;
    }
    echo json_encode($result);

}
else{
    $MSG = 'Try Again. Possible connection failure.' ;
    if ($connect==true){
        $MSG = 'Connected but sql fail';
    }
     $json = json_encode($MSG);
    
    // Echo the message.
    echo $json ;
   
}


    
 
mysqli_close($connect);
?>
