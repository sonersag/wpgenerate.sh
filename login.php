<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
    <title>Sunucu Paneli</title>
    
    
    <link rel="stylesheet" href="css/reset.css">

    <link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900'>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

        <link rel="stylesheet" href="css/style.css">
    
  </head>
  <body>

<div class="pen-title">

<?php
 
include("ayar.php");
//echo $_POST['user'];
//echo $_POST['pass'];


session_start();
ob_start();
 
if(($_POST["user"]==$user) and ($_POST["pass"]==$pass)){
 
$_SESSION["login"] = "true";
$_SESSION["user"] = $user;
$_SESSION["pass"] = $pass;
header("Location:a2dfvghbtfrt4.php");
 
}else{
 
echo "<h1>Kullanıcı adı veya Şifre Yanlış.</h1>";
header("Refresh: 2; url=index.html");
 
}
 
ob_end_flush();
?>
</div>
