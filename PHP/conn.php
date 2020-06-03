<?php
  $dbhost = 'localhost';
  $dbuser = 'SdGroup';
  $dbpass = 'InSky!20';
  $db='PostGradTrackDB';
  $connect = new mysqli($dbhost,$dbuser,$dbpass,$db);
if($connect){
  //echo "Connected!";
}else{
    echo "Connection failed";
    exit();
}

?>