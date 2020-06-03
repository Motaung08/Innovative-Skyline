<?php

include 'conn.php';
$ProjectID=$_POST['ProjectID'];


   $query = "SELECT * FROM List WHERE List.ProjectID='".$ProjectID."'"; 


$queryResult=$connect->query($query);

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);

?>