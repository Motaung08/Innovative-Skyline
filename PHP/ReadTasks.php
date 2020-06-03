<?php

include 'conn.php';
$ListID=$_POST['ListID'];


   $query = "SELECT * FROM Task WHERE Task.ListID='".$ListID."'"; 


$queryResult=$connect->query($query);

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);

?>