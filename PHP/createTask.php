<?php

include "conn.php";

$json = file_get_contents('php://input');
$obj = json_decode($json,true);
 
$ListID=$obj['ListID'];
$Task_Title = $obj['Task_Title'];
$Task_AddedBy = $obj['Task_AddedBy'];
$Task_DateAdded = $obj['Task_DateAdded'];
$Task_Description = $obj['Task_Description'];
$Task_Due = $obj['Task_Due'];
$Task_StatusID = $obj['Task_StatusID'];


if($Task_DateAdded!=null){
    if($Task_Description!=null){
        if($Task_Due!=null){
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_Description, Task_AddedBy, Task_StatusID, Task_Date_added, Task_Date_Due) VALUES (NULL, '$ListID', '$Task_Title', '$Task_Description', '$Task_AddedBy', '$Task_StatusID', '$Task_DateAdded', '$Task_Due');";
        }
        else{
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_Description, Task_AddedBy, Task_StatusID, Task_Date_added) VALUES (NULL, '$ListID', '$Task_Title', '$Task_Description', '$Task_AddedBy', '$Task_StatusID', '$Task_DateAdded');";
        }
    }
    else{
        if($Task_Due!=null){
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_AddedBy, Task_StatusID, Task_Date_added, Task_Date_Due) VALUES (NULL, '$ListID', '$Task_Title', '$Task_AddedBy', '$Task_StatusID', '$Task_DateAdded', '$Task_Due');";
        }
        else{
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_AddedBy, Task_StatusID, Task_Date_added) VALUES (NULL, '$ListID', '$Task_Title', '$Task_AddedBy', '$Task_StatusID', '$Task_DateAdded');";
        }
    }
}else{
    if($Task_Description!=null){
        if($Task_Due!=null){
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_Description, Task_AddedBy, Task_StatusID, Task_Date_Due) VALUES (NULL, '$ListID', '$Task_Title', '$Task_Description', '$Task_AddedBy', '$Task_StatusID', '$Task_Due');";
        }
        else{
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_Description, Task_AddedBy, Task_StatusID) VALUES (NULL, '$ListID', '$Task_Title', '$Task_Description', '$Task_AddedBy', '$Task_StatusID');";
        }
    }
    else{
        if($Task_Due!=null){
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_AddedBy, Task_StatusID,  Task_Date_Due) VALUES (NULL, '$ListID', '$Task_Title', '$Task_AddedBy', '$Task_StatusID', '$Task_Due');";
        }
        else{
            $ListQuery="INSERT INTO Task (TaskID, ListID, Task_Title, Task_AddedBy, Task_StatusID, ) VALUES (NULL, '$ListID', '$Task_Title', '$Task_AddedBy', '$Task_StatusID');";
        }
    }
}

    if(mysqli_query($connect,$ListQuery)){

        $MSG = 'Task created!' ;
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

mysqli_close($connect);
?>