<?php

include 'conn.php';

 $query = "SELECT * FROM StudentType";
//$query = "SELECT Student_Type FROM StudentType WHERE StudentTypeID='1'";


$queryResult=$connect->query($query);

//echo json_encode($queryResult);

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);

?>