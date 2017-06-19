var i=0;
var map;

var markers=[];

//initial configuration of the map
function initialize() {
  //the entire world
  var latlng = new google.maps.LatLng(0, 0);
  var mapOptions = {
    zoom: 2,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  //set markers with top 10 earthquakes this year and make list
  setMarkers(true);
  //heading of page
  document.getElementById('location').innerHTML="Top 10 Earthquakes Last Year";
}

function setMarkers(initialize){
  //only do it when map changes location
   google.maps.event.addListenerOnce(map, 'bounds_changed', function() {
      var limits=map.getBounds();
      var north=limits.getNorthEast().lat();
      var east=limits.getNorthEast().lng();
      var south=limits.getSouthWest().lat();
      var west=limits.getSouthWest().lng();
	  var dateFilter='';
	  if(initialize){
		//Load top 10 earthquakes
		dateFilter='yes';
	  }else{
		//Load earthquakes by location names 
		dateFilter='no';
	  }
	  
	  dhr.GoogleMapMultiMarker1CTRL.doCallout1(north,south,east,west,dateFilter,
	  function(result, event){
		if (event.status){
			if(initialize){
				//Load top 10 earthquakes
				defineInitialMarkers(result);
			}else{
				//Load earthquakes by location names 
				defineMarkers(result);
			}
		}
	  },{escape:true});
    });
}

//set markers with top 10 earthquakes this year and make list
function defineInitialMarkers(response){
  var contentString=[];
  //we want only results from the last year
  //Need 2 counters, j is for the number of results from last year.  
  var j=0;
  //HTML of the list of 10 earthquakes
  var EQlist="Top Earthquakes Last Year:<br/>";
  //Results are ordered by magnitude
  for(var i=0;i<response.length;i++)
  { 
		//Include all the information in a infowindow that pops up when we press the marker
        contentString[i] ='<div id="content">' +
              '<h1> Eqid:'+ response[i].eqid + '</h1>' +
              '<p> Magnitude: ' + response[i].magnitude + '   Depth: '+ response[i].depth + '</p>' +
              '<p> Latitude: ' + response[i].lat + '   Longitude: '+ response[i].lng + '</p>' +
              '<p> Time: ' + response[i].datetime + '   Source: '+ response[i].src + '</p>' +
              '</div>';

        //Add result to list
        EQlist+=(j+1)+") Equid: " + response[i].eqid+ ", Magnitude: " + response[i].magnitude + "<br/>";
        
        var infowindow = new google.maps.InfoWindow();

         //locate marker
        var myLatlng=new google.maps.LatLng(response[i].lat,response[i].lng);
        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: 'Earthquake'
         });

        //Add listener so each time we click, the corresponding infowindow pops up
        google.maps.event.addListener(marker, 'click', (function(marker, j) {
          return function() {
            infowindow.setContent(contentString[j]);
          infowindow.open(map, marker);
         }
        })(marker, j));

        //Add it to array of markers
        markers.push(marker);
        
        //only want 10 results
        j++;
        if(j>9){
          break;
        }
  }

  //Remove last blank line (<br/>) from list and add it to correct place
  EQlist=EQlist.substring(0,EQlist.length-5);
  document.getElementById('list').innerHTML=EQlist;
}

//define markers based on the earthquake response
function defineMarkers (response){
  //Array of info about different earthquakes
  var contentString=[];
  for(var i=0;i<response.length;i++)
  {   
      //Include all the information in a infowindow that pops up when we press the marker
      contentString[i] ='<div id="content">' +
              '<h1> Eqid:'+ response[i].eqid + '</h1>' +
              '<p> Magnitude: ' + response[i].magnitude + '   Depth: '+ response[i].depth + '</p>' +
              '<p> Latitude: ' + response[i].lat + '   Longitude: '+ response[i].lng + '</p>' +
              '<p> Time: ' + response[i].datetime + '   Source: '+ response[i].src + '</p>' +
              '</div>';

      var infowindow = new google.maps.InfoWindow();

      //locate marker
      var myLatlng=new google.maps.LatLng(response[i].lat,response[i].lng);
      var marker = new google.maps.Marker({
         position: myLatlng,
         map: map,
        title: 'Earthquake'
      });

      //Add listener so each time we click, the corresponding infowindow pops up
      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
            infowindow.setContent(contentString[i]);
            infowindow.open(map, marker);
        }
      })(marker, i));

      //add marker to array of markers.
      markers.push(marker);

  }

}

//everytime we search for other location
function updateLocation() {
  resetMarkers();
  setLocation();
  setMarkers(false);
}

//Everytime we change location, eliminate old earthquakes
function resetMarkers(){
  //take them out of map and reset array of markers
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers=[];
}

//change map to center it on location
function setLocation(){
  var geocoder = new google.maps.Geocoder();
  //location searched
  var address = document.getElementById('address').value;
  //heading of page
  document.getElementById('location').innerHTML="Earthquakes around " + address;
  
  //search location in google maps and use first result
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      //center as center of location
      map.setCenter(results[0].geometry.location);
      //adapt zoom level to include entire location and is surroundings
      if (results[0].geometry.viewport) 
          map.fitBounds(results[0].geometry.viewport);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);