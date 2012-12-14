// - Dependencies
var config  = require('./config/app'),
	redis   = require("redis")

// - Redis pubsub
var host = "ec2-23-23-8-2.compute-1.amazonaws.com";
var port = "6379";
var postUrl = "http://"+host+":8080/auth/user/delete";
subscribe  = redis.createClient(port, host);
publish    = redis.createClient(port, host);
var request = require('request');


var object = process.argv[2];

if (object == null) {

	  console.log("invalid object"); 
	  console.log("usage: cleanup.js object userId (where object is user or photo) "); 
	  process.exit(1);
}

var userId = process.argv[3];

if (userId == null) {

	  console.log("invalid user Id"); 
	  console.log("usage: cleanup.js object userId (where object is user or photo) "); 
	  process.exit(1);
}

if (object == "photo") {
		console.log("deleting photos for user "+userId);
		deletePhoto = { "action" : "deleteAll",
				 "request":  {
				 	"user" : {
				 		"id" : userId
				 	}
				 },
				 "callback" : "deleteCB"
		};

		strPhoto = JSON.stringify(deletePhoto)
		
		
		publish.publish('photo', strPhoto);
    	subscribe.subscribe("deleteCB");

		subscribe.on("message", function (channel, message) {
	  		console.log("redis client received msg " + channel + ": " + message);
	        }
		);
}

if (object == "user") {
	console.log("deleting user object");
	usr = {"id" : userId};
	strUsr = JSON.stringify(usr);
	request.post({
        headers: {'content-type' : 'application/json'},
        url: postUrl,
         body: strUsr
         }, function(error, response, body){
            console.log(body);
    });
}
