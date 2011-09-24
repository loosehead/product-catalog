<?php
 require_once "Mail.php";
 
 $from = "Sandra Sender <info@elpudu.com>";
 $to = "Ramona Recipient <natlehmann@gmail.com>";
 $subject = "prueba pudu";
 $body = "funciono!!!";
 
 $host = "mail.elpudu.com";
 $username = "info";
 $password = "elpudu2011";
 
 $headers = array ('From' => $from,
   'To' => $to,
   'Subject' => $subject);
 $smtp = Mail::factory('smtp',
   array ('host' => $host,
     'auth' => true,
     'username' => $username,
     'password' => $password));
 
 $mail = $smtp->send($to, $headers, $body);
 
 if (PEAR::isError($mail)) {
   echo("<p>" . $mail->getMessage() . "</p>");
  } else {
   echo("<p>Message successfully sent!</p>");
  }
  
  echo "llegue";
 ?>
