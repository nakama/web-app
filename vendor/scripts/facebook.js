// Additional JS functions here
window.fbAsyncInit = function() {
  FB.init({
    appId      : '229944863802496', // App ID
    channelUrl : '//naka.ma/channel.html', // Channel File
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });

  // Additional init code here
  FB.getLoginStatus(function(response) {
    if (response.status === 'connected') {
      // connected
    } else if (response.status === 'not_authorized') {
      // not_authorized
    } else {
      // not_logged_in
    }
  });

  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
        console.log('Good to see you, ' + response.name + '.');
    });
  }
};

// Load the SDK Asynchronously
(function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
 }(document));