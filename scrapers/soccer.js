var Twitter = require('twitter');
var parse = require('csv-parse');
var stringify = require('csv-stringify');
var async = require('async');

var client = new Twitter({
  consumer_key: 'jZ3TJDhFFaPJpATgmMZeGzABu',
  consumer_secret: 'oSDra5nzEqmEuBoixBY1IZ4SwjQf8QsKMKwlsCPZXfLWenTnK6',
  access_token_key: '2483933900-bRZYrXiUEeRbCnp4i9qyiH3JGGUtlenAx6qio0v',
  access_token_secret: '70JzMqWnIb1hiIoGaabXdKPjnUYBWraaNJEnYc9QYUfI7'
});


var twitter = []

function cb(twitter){
   		stringify(twitter, function(err, csv){
   		 	console.log(twitter)
			fs.writeFile('twitter_data_7201-8000.csv', csv, function (err) {
			  if (err) return console.log(err);
			  console.log('done');
			});
		});
}

fs = require('fs')
fs.readFile('soccer6.csv', {encoding: 'binary'}, function (err,data) {
  if (err) {
    return console.log(err);
  }

  	parse(data, function(err, output){
  		console.log(output[1])
  		output.sort(sortFunction);
  		test = output.sort(sortFunction).slice(7201,8000)

		async.each(test, function(player, callback) {

		      var params = {q: player[0]};


				client.get('users/search', params, function(error, response) {
				  if(error) console.log(error)
				  if (!error && response.length > 0) {
				  	var res = 0
				  	/*if(response.length > 4){
				  		for (var i = 1; i <5; i++) {
				  			if( response[i].followers_count > response[res].followers_count) res = i;
				  		}
				  	}*/
				    console.log(response[res].followers_count );
				    twitter.push([player[0], response[0].screen_name, response[res].followers_count])
				  }
				  	 callback()
				});
		}, function(err) {
		    if( err ) {

		      console.log('A file failed to process');
		    } else {
		      cb(twitter)
		    }
		});



	});
});










function sortFunction(a, b) {
	var x = parseInt(a[1]);
	var y = parseInt(b[1]);
    if (x === y) {
        return 0;
    }
    else {
        return (x < y) ? 1 : -1;
    }
}
