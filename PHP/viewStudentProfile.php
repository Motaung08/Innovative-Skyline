<?php

include 'conn.php';
 
$Email=$_POST['Email'];

$query = "SELECT * FROM Students WHERE lower(Student_Email)='".$Email."'";


$queryResult=$connect->query($query);

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);

?>