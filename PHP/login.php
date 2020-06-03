<?php

include 'conn.php';

//$Email='1713445@students.wits.ac.za';
//$Password='Meghan';
 $Email=$_POST['Email'];
 $Password=$_POST['Password'];

$sql = "SELECT * FROM User WHERE lower(Email)='$Email' ";

$result = $connect->query($sql);
$out=array();

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    //echo "Email: " . $row["Email"]. " - Password: " . $row["Password"]. "<br>";
    if (password_verify($Password, $row["Password"])) {
    //echo 'Password is valid!';
    $out[]=$row;
    } 
    else 
    {
        echo json_encode('Invalid password.');
    }
  }
  echo json_encode($out);
} else {
  echo json_encode("No user found.");
}

?>