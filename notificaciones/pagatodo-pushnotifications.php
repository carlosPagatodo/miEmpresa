<?php

	    $pass = '';

        $message = $_GET['message'];
        $args = $_GET['args'];
		$token = $_GET['token'];

        $badge = 1;

		$alert = array();
        $alert['loc-key'] = $message;
        $alert['loc-args'] = array($args);

        $body = array();
        $body['aps'] = array('alert' => $alert);
        $body['aps']['badge'] = $badge;
        $body['aps']['sound'] = 'default';



        $payload = json_encode($body);

print $payload . "<br>";

$apnsHost = 'gateway.sandbox.push.apple.com';
//$apnsHost = 'gateway.push.apple.com'; produccion
$apnsPort = 2195;
$apnsCert = 'pagatodo-apns-dev.pem';
//$apnsCert = 'pagatodo-apns-dist.pem'; produccion


$streamContext = stream_context_create();
stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);

$apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, $errorString, 2, STREAM_CLIENT_CONNECT, $streamContext);

        if (!$apns) {
         print "Failed to connect $error $errorString<br>";
         return;
        }
        else {
	        print "Connection OK<br>";
        }


            printf ("Enviando - %s<br>", htmlspecialchars($token));

			$apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '', htmlspecialchars($token))) . chr(0) . chr(strlen($payload)) . $payload;
			fwrite($apns, $apnsMessage);

        


fclose($apns);

print "Finalizado";

        ?>