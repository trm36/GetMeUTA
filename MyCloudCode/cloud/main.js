
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


Parse.Cloud.define("stop_times", function(request, response) {
  //build the corrected stop_times array
  var resultStopTimes = [];
  
  //get the stop times for the given stop id
  var query = new Parse.Query("stop_times");
  query.equalTo("stop_id", request.params.stop_id);
  query.find({
  	//if stop times query is successful, put it in the array
    success: function(results) {
      resultStopTimes = results;
      
      //get the route and service id for each trip id in each stop time
      //first, loop over stop_times
      for(var i=0; i < resultStopTimes.length; i++) {
      	//next, loop over trip id's
      	for(var i=0; i < resultStopTimes.get("trip_id"))
      	var tripQuery = new Parse.Query("trips");
      	tripQuery.equalTo("trip_id", resultStopTimes[i]["trip_id"]);
      	tripQuery.find({
      		success: function(tripResults) {
      		  resultStopTimes[i]["trips"] = [];
      		  resultStopTimes[i]["trips"].push({
      		  	"trip_id": { 
      		  				  "route_id": tripResults.get("route_id"),
      		  	              "service_id": tripResults.get("route_id") 
      		  	           }
      		  });
      		},

      		error: function() {	
             response.error("trips lookup failed");
            }  
      	});
      
      }





    },
    //if error, return an error message
    error: function() {	
      response.error("stop_times lookup failed");
    }
  });




  response.success(resultStopTimes);	
})
