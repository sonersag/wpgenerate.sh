<?php
$domain=$_POST['domain'];

$output = shell_exec("./wpgenerate.sh $domain");
echo "<pre>$output</pre>";

?>
