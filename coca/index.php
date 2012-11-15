<?
  // Remember to copy files from the SDK's src/ directory to a
  // directory in your application on the server, such as php-sdk/
  require_once('facebookApi/facebook.php');
  
  $mycanvas_page = 'https://apps.facebook.com/167679959983879/';
  
  if (isset($_GET['code'])){
	echo("<script type='text/javascript'> top.location.href='" . $mycanvas_page . "'</script>");
  }
  
  $config = array(
    'appId' => '167679959983879',
    'secret' => '36111ef246ac705f55e7dd57ad526146',
  );
	
  $params = array(
  	'scope' => 'user_about_me, user_birthday, user_hometown, user_location, email',
  );
  
  $facebook = new Facebook($config);
  $user_id = $facebook->getUser();
  $access_token = $facebook->getAccessToken();
?>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
  <body>
<div id="fb-root"></div>
	<script type="text/javascript">
        window.fbAsyncInit = function () {
            FB.init({ appId: '167679959983879', status: true, cookie: true, xfbml: true });
            FB.Canvas.setSize({ height: 620 });
        };
        (function () {
            var e = document.createElement('script');
            e.type = 'text/javascript';
            e.src = document.location.protocol +
                '//connect.facebook.net/en_US/all.js';
            e.async = true;
            document.getElementById('fb-root').appendChild(e);
        } ());
    </script>

  <?
    if($user_id) {

      // We have a user ID, so probably a logged in user.
      // If not, we'll get an exception, which we handle below.
      try {
        $user_profile = $facebook->api('/me','GET');
        //echo "Name: " . $user_profile['name']."<br/>";
		
		$user_friend = $facebook->api('/me/friends');
		foreach ($user_friend['data'] as $friend) {
			  //echo $friend['id']."<br/>".$friend['name']."<br/>";
		}

      } catch(FacebookApiException $e) {
        // If the user is logged out, you can have a 
        // user ID even though the access token is invalid.
        // In this case, we'll get an exception, so we'll
        // just ask the user to login again here.
        $login_url = $facebook->getLoginUrl($params);
        echo("<script type='text/javascript'> top.location.href='" . $login_url . "'</script>");
        error_log($e->getType());
        error_log($e->getMessage());
      }   
    } else {
      // No user, print a link for the user to login
      $login_url = $facebook->getLoginUrl($params);
      echo("<script type='text/javascript'> top.location.href='" . $login_url . "'</script>");
    }

  ?>
	
    <div id="flashContent" align="center">
			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="760" height="570" id="Coca" align="middle">
				<param name="movie" value="Coca.swf" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#D9F2FF" />
				<param name="play" value="true" />
				<param name="loop" value="true" />
				<param name="wmode" value="opaque" />
				<param name="scale" value="showall" />
				<param name="menu" value="true" />
				<param name="devicefont" value="false" />
				<param name="salign" value="" />
				<param name="allowScriptAccess" value="sameDomain" />
				<param name="allowFullScreen" value="true" />
                <param name=FlashVars value="userFacebookId=<?=$user_id?>&userFacebookName=<?=$user_profile['first_name']?>&userLastname=<?=$user_profile['last_name']?>&userGender=<?=$user_profile['gender']?>&userEmail=<?=$user_profile['email']?>&userBirthday=<?=$user_profile['birthday']?>&userAddressCurrentLocation=<?=$user_profile['location']['name']?>&userAddressHometown=<?=$user_profile['hometown']['name']?>" />
				<!--[if !IE]>-->
  			<object type="application/x-shockwave-flash" data="Coca.swf" width="760" height="570">
                <param name="movie" value="Coca.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#D9F2FF" />
                <param name="play" value="true" />
                <param name="loop" value="true" />
                <param name="wmode" value="opaque" />
                <param name="scale" value="showall" />
                <param name="menu" value="true" />
                <param name="devicefont" value="false" />
                <param name="salign" value="" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="allowFullScreen" value="true" />
                <param name=FlashVars value="userFacebookId=<?=$user_id?>&userFacebookName=<?=$user_profile['first_name']?>&userLastname=<?=$user_profile['last_name']?>&userGender=<?=$user_profile['gender']?>&userEmail=<?=$user_profile['email']?>&userBirthday=<?=$user_profile['birthday']?>&userAddressCurrentLocation=<?=$user_profile['location']['name']?>&userAddressHometown=<?=$user_profile['hometown']['name']?>" />
				<!--<![endif]-->
                <a href="http://www.adobe.com/go/getflash">
                    <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
                </a>
				<!--[if !IE]>-->
				</object>
				<!--<![endif]-->
			</object>
	</div>
    <table width="100%" border="0">
      <tr>
        <td align="center"><br>
        cocaland@coca.com</td>
      </tr>
    </table>
</body>
</html>
