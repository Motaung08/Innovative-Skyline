<?php
 
include "conn.php";
$json = file_get_contents('php://input');
$obj = json_decode($json,true);
 
 
$TaskID = $obj['TaskID'];
$ListID = $obj['ListID'];
$Task_Title = $obj['Task_Title'];
$Task_Description = $obj['Task_Description'];
//$AddedBy = $obj['Task_AddedBy'];
$StatusID = $obj['Task_StatusID'];
$DateAdded = $obj['Task_Date_added'];
$DueDate = $obj['Task_Date_Due'];

    if($Task_Title!=null){
        if($Task_Description!=null){
            if($StatusID!=null){
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', Task_StatusID='$StatusID', Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', Task_StatusID='$StatusID', Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', Task_StatusID='$StatusID',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', Task_StatusID='$StatusID' WHERE TaskID='$TaskID'";
                    }
                    
                }
            }
            else{
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title',Task_Description='$Task_Description', WHERE TaskID='$TaskID'";
                    }
                    
                }
            }
            
        }
        else{
            if($StatusID!=null){
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', Task_StatusID='$StatusID', Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', Task_StatusID='$StatusID', Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', Task_StatusID='$StatusID',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', Task_StatusID='$StatusID' WHERE TaskID='$TaskID'";
                    }
                    
                }
            }
            else{
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Title='$Task_Title', WHERE TaskID='$TaskID'";
                    }
                    
                }
            }
        }
        
    }
    else{
       if($Task_Description!=null){
            if($StatusID!=null){
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', Task_StatusID='$StatusID', Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', Task_StatusID='$StatusID', Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', Task_StatusID='$StatusID',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', Task_StatusID='$StatusID' WHERE TaskID='$TaskID'";
                    }
                    
                }
            }
            else{
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Description='$Task_Description', WHERE TaskID='$TaskID'";
                    }
                    
                }
            }
            
        }
        else{
            if($StatusID!=null){
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_StatusID='$StatusID', Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_StatusID='$StatusID', Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_StatusID='$StatusID',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_StatusID='$StatusID' WHERE TaskID='$TaskID'";
                    }
                    
                }
            }
            else{
                if($DateAdded!=null){
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Date_added='$DateAdded',Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="UPDATE Task SET Task_Date_added='$DateAdded' WHERE TaskID='$TaskID'";
                    }
                }
                else{
                    if($DueDate!=null){
                        $Sql_Query="UPDATE Task SET Task_Date_Due='$DueDate' WHERE TaskID='$TaskID'";
                    }
                    else{
                        $Sql_Query="";
                    }
                    
                }
            }
        }
    }


if($Sql_Query!=""){
    if(mysqli_query($connect,$Sql_Query)){

        $MSG = 'Task updated successfully' ;
        $json = json_encode($MSG);
         echo $json ;
    }
    else{
	    $MSG = 'Try again.' ;
		$json = json_encode($CheckSQL);
		 echo $json ;
    }
}
else{
    $MSG = 'Nothing to update.' ;
		$json = json_encode($CheckSQL);
		 echo $json ;
}

mysqli_close($connect);
?>