<?php

include 'conn.php';
$userTypeID=$_POST['UserTypeID'];
$StudentNo=$_POST['StudentNo'];
$StaffNo=$_POST['StaffNo'];

if ($userTypeID=="1"){
   $query = "SELECT Project_Board.ProjectID, Project_Board.Project_Title, Project_Board.Project_Description, Project_Board.Project_StartDate, Project_Board.Project_EndDate, Assignment.AccessLevelID FROM Project_Board, Assignment WHERE Project_Board.ProjectID=Assignment.ProjectID AND lower(Assignment.StudentNo)='".$StudentNo."' GROUP BY Assignment.ProjectID";
}
else{
       $query = "SELECT Project_Board.ProjectID, Project_Board.Project_Title, Project_Board.Project_Description, Project_Board.Project_StartDate, Project_Board.Project_EndDate, Assignment.AccessLevelID FROM Project_Board, Assignment WHERE Project_Board.ProjectID=Assignment.ProjectID AND lower(Assignment.StaffNo)='".$StaffNo."' GROUP BY Assignment.ProjectID";
}

$queryResult=$connect->query($query);

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);


?>