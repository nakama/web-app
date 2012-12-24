module.exports = {
	app: {
		cookie_secret: "yodaddy",
		port: 3001,
		session_secret: "yomama",
		static: "/public",
		redis : {
			active: false,
			port: 6379,
			host:"ec2-23-23-8-2.compute-1.amazonaws.com"
		}, 
		oauth: {
			dropbox: {
				live: {
					appKey: "5w2qboy9wkjpej6",
					appSecret: "rlbwm4fqx3ndeo5"
				},

				local: {
					appKey: "q9l409siztkh9f5",
					appSecret: "lmjt1b0voq3cwr1"
				}
			},

			facebook: {
				live: {
					appId: "273372639423261",
					appSecret: "46583988286257bc43a246e98f605031"
				},

				local: {
					appId: "229944863802496",
					appSecret: "d9eeba3d5da72ea76387b365bb1c0142"
				}
			},

			google: {
				live: {
					clientId: "226213582369.apps.googleusercontent.com",
					clientSecret: "Vd96mzuj8qBiljYIXbeDmvgz"
				}
			},

			instagram: {
				live: {
					clientId: "181bd8727613437f9f50e5b4aea03572",
					clientSecret: "e4b56c5f1ebb449d90cd7158a24f07fc"
				},

				local: {
					clientId: "6692e4c309da4c859e8c3c8c0cde263b",
					clientSecret: "828ad3c00a5b402daed2c0b56c0f86af"
				}
			},

			twitter: {
				live: {
					consumerKey: "K5zOSB06T3cvc2YtnNNhdQ",
					consumerSecret: "nuS990WBF0P55HFcwtOU5jrZaCBmGz0iHG5PNoAASd8"
				},

				local: {
					consumerKey: "boV5E4GQ0tTiOc1iz27A",
					consumerSecret: "4kJQBwDfm0oAiY0UJKmCIgyWbp2fUxh0IkihXFMe6s"
				}
			}
		}
	}
}