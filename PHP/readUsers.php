<?php

include 'conn.php';


   $query = "SELECT * FROM User"; 

$queryResult=$connect->query($query);

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);

?>