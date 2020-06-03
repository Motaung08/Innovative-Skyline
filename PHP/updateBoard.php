<?php
include "conn.php";
$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$BoardID= $obj['BoardID'];
$Title= $obj['Title'];
$Description= $obj['Description'];
$Start= $obj['Start'];
$End= $obj['End'];

    if($Title!=null){
        if($Description!=null){
            if($Start!=null){
                if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."', Project_Board.Project_Description='$Description', Project_Board.Project_StartDate='$Start', Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//End is null
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."', Project_Board.Project_Description='$Description', Project_Board.Project_StartDate='$Start' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
            }
            else{//Start is null
                 if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."', Project_Board.Project_Description='$Description', Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//Start and End is null
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."', Project_Board.Project_Description='$Description' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
            }
            
        }
        else{//Description is null
            if($Start!=null){
                if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."', Project_Board.Project_StartDate='$Start', Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//End is null
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."',  Project_Board.Project_StartDate='$Start' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
            }
            else{//Start is null
                 if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."', Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//Start and End is null
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Title='".$Title."' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
            }
        }
        
    }
    else{//Title is null
        if($Description!=null){
            if($Start!=null){
                if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Description='$Description', Project_Board.Project_StartDate='$Start', Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//End is null
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Description='$Description', Project_Board.Project_StartDate='$Start' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
            }
            else{//Start is null
                 if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Description='$Description', Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//Start and End is null
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_Description='$Description' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
            }
            
        }
        else{//Description is null
            if($Start!=null){
                if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_StartDate='$Start', Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//End is null
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_StartDate='$Start' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
            }
            else{//Start is null
                 if($End!=null){
                    $Sql_Query="UPDATE Project_Board SET Project_Board.Project_EndDate='$End' WHERE Project_Board.ProjectID='".$BoardID."'";
                }
                else{//Title, Description,Start and End is null
                    $Sql_Query=null;
                }
            }
        }
    }


if($Sql_Query!=null){
    if(mysqli_query($connect,$Sql_Query)){
    
         // If the record inserted successfully then show the message.
        $MSG = 'Board updated successfully' ;
         
        // Converting the message into JSON format.
        $json = json_encode($MSG);
         
        // Echo the message.
         echo $json ;
    
    }

    else{
 
	 
	    $MSG = 'Try again.' ;
		$json = json_encode($CheckSQL);
		 
		// Echo the message.
		 echo $json ;
	 
	 
    }
}
else{
    $MSG = 'Nothing to update.' ;
		$json = json_encode($CheckSQL);
		 
		// Echo the message.
		 echo $json ;
}

mysqli_close($connect);
?>