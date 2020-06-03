<?php

include "conn.php";
$json = file_get_contents('php://input');
$obj = json_decode($json,true);
$BoardID=$obj['ProjectID'];

$BoardQuery="DELETE FROM Project_Board WHERE ProjectID='$BoardID';";


if($BoardID!='null'){
    if(mysqli_query($connect,$BoardQuery)){

    $MSG = 'Board DELETED!' ;
    $json = json_encode($MSG);
    echo $json ;

    }
    else{
        $MSG = 'Try Again' ;
        if ($connect==true){
            $MSG = 'Connected but sql fail';
        }
        $json = json_encode($MSG);
        echo $json ;

    }
}else{
    $MSG='Board ID is null!';
    $json = json_encode($MSG);
        echo $json ;
}

    
 
mysqli_close($connect);
?>
