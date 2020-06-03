<?php
include "conn.php";
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
$studentNo=$obj['StudentNo'];
$staffNo = $obj['StaffNo'];
$userType = $obj['userType'];
$title = $obj['Project_Title'];
$description = $obj['Project_Description'];
$startDate = $obj['Project_StartDate'];
$endDate = $obj['Project_EndDate'];

// $studentNo=null;
// $staffNo = 'A00';
// $userType = '2';
// $title = 'abc sup test';
// $description = '';
// $startDate = null;
// $endDate = null;

    if($description!=null){
        if($startDate!=null){
            if($endDate!=null){
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description,Project_StartDate,Project_EndDate) VALUES('".$title."','$description','$startDate','$endDate');";
            }
            else{
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description,Project_StartDate) VALUES('".$title."','$description','$startDate');";
            }
        }
        else{//start date is null
            if($endDate!=null){
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description,Project_EndDate) VALUES('".$title."','$description','$endDate');";
            }
            else{
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description) VALUES('".$title."','$description');";
            }
        }
    }else{
        if($startDate!=null){
            if($endDate!=null){
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description,Project_StartDate,Project_EndDate) VALUES('".$title."','$description','$startDate','$endDate');";
            }
            else{
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description,Project_StartDate) VALUES('".$title."','$description','$startDate');";
            }
        }
        else{//start date is null
            if($endDate!=null){
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description,Project_EndDate) VALUES('".$title."','$description','$endDate');";
            }
            else{
                $BoardQuery="INSERT INTO Project_Board (Project_Title,Project_Description) VALUES('".$title."','$description');";
            }
        }
    }


if($userType=='1'){
    
    $AssocQuery="INSERT INTO Assignment (ProjectID,StudentNo) VALUES(LAST_INSERT_ID(),'".$studentNo."')";

}
else{
    
    $AssocQuery="INSERT INTO Assignment (ProjectID,StaffNo) VALUES(LAST_INSERT_ID(),'$staffNo')";
}

//echo json_encode($BoardQuery);

if(mysqli_query($connect,$BoardQuery)){

    
    if (mysqli_query($connect,$AssocQuery)){
        // If the record inserted successfully then show the message.
    $MSG = 'Board AND Association created!' ;
    
        
    }else{
        // If the record inserted successfully then show the message.
    $MSG = 'Board created Successfully, but issue with association' ;
    }

}
else{
    $MSG = 'Try Again' ;
    if ($connect==true){
        $MSG = 'Connected but sql fail';
    }
   

}

 $json = json_encode($MSG);
    
    // Echo the message.
    echo $json ;
    
 
mysqli_close($connect);
?>
