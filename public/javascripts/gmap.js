var gmap;
var gdir;
var geocoder = null;
var addressMarker;

function gmap_initialize() {
  if (GBrowserIsCompatible()) {      
    gmap = new GMap2(document.getElementById("map_canvas"));
    gdir = new GDirections(gmap, document.getElementById("directions"));
    GEvent.addListener(gdir, "addoverlay", gmap_onGDirectionsLoad);
    GEvent.addListener(gdir, "error", gmap_handleErrors);
    geocoder = new GClientGeocoder();
  }
}

function gmap_setDirections(fromAddress, toAddress, locale) {
  if (gmap == null) 
    gmap_initialize();

  gdir.load("from: " + fromAddress + " to: " + toAddress, { "locale": locale });
}

function gmap_handleErrors(){
 if (gdir.getStatus().code == G_GEO_UNKNOWN_ADDRESS)
   alert("No corresponding geographic location could be found for one of the specified addresses. This may be due to the fact that the address is relatively new, or it may be incorrect.\nError code: " + gdir.getStatus().code);
 else if (gdir.getStatus().code == G_GEO_SERVER_ERROR)
   alert("A geocoding or directions request could not be successfully processed, yet the exact reason for the failure is not known.\n Error code: " + gdir.getStatus().code);
 else if (gdir.getStatus().code == G_GEO_MISSING_QUERY)
   alert("The HTTP q parameter was either missing or had no value. For geocoder requests, this means that an empty address was specified as input. For directions requests, this means that no query was specified in the input.\n Error code: " + gdir.getStatus().code);
 else if (gdir.getStatus().code == G_GEO_BAD_KEY)
   alert("The given key is either invalid or does not match the domain for which it was given. \n Error code: " + gdir.getStatus().code);
 else if (gdir.getStatus().code == G_GEO_BAD_REQUEST)
   alert("A directions request could not be successfully parsed.\n Error code: " + gdir.getStatus().code);
 else 
   alert("An unknown error occurred.");
}

function gmap_onGDirectionsLoad(){ 
 var poly = gdir.getPolyline();
 if (poly.getVertexCount() > 200) {
   alert("This route has too many vertices");
   return;
 }
 var baseUrl = "http://maps.google.com/staticmap?";

 var params = [];
 var markersArray = [];
 markersArray.push(poly.getVertex(0).toUrlValue(5) + ",greena");
 markersArray.push(poly.getVertex(poly.getVertexCount()-1).toUrlValue(5) + ",greenb");
 params.push("markers=" + markersArray.join("|"));

 var polyParams = "rgba:0x0000FF80,weight:5|";
 var polyLatLngs = [];
 for (var j = 0; j < poly.getVertexCount(); j++) {
   polyLatLngs.push(poly.getVertex(j).lat().toFixed(5) + "," + poly.getVertex(j).lng().toFixed(5));
 }
 params.push("path=" + polyParams + polyLatLngs.join("|"));
 params.push("size=300x300");
 params.push("key=ABQIAAAAN1NowbApvh7-dSrapHLVrhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxTDQieqPfxOqSSOUAU7dZyEab-prg");

 baseUrl += params.join("&");

 var extraParams = [];
 extraParams.push("center=" + gmap.getCenter().lat().toFixed(6) + "," + gmap.getCenter().lng().toFixed(6));
 extraParams.push("zoom=" + gmap.getZoom());
 gmap_addImg(baseUrl + "&" + extraParams.join("&"), "staticMapOverviewIMG");

 var extraParams = [];
 extraParams.push("center=" + poly.getVertex(0).toUrlValue(5));
 extraParams.push("zoom=" + 15);
 gmap_addImg(baseUrl + "&" + extraParams.join("&"), "staticMapStartIMG");

 var extraParams = [];
 extraParams.push("center=" + poly.getVertex(poly.getVertexCount()-1).toUrlValue(5));
 extraParams.push("zoom=" + 15);
 gmap_addImg(baseUrl + "&" + extraParams.join("&"), "staticMapEndIMG");
}

function gmap_addImg(url, id) {
 var img = document.createElement("img");
 img.src = url;
 document.getElementById(id).innerHTML = "";
 document.getElementById(id).appendChild(img);
}

function gmap_showAddress(id, address) {
  var gmap, geocoder;

  if (GBrowserIsCompatible()) {      
    gmap = new GMap2(document.getElementById(id));
    geocoder = new GClientGeocoder();
  }

  if (geocoder) {
    geocoder.getLatLng(
      address,
      function(point) {
        if (!point) {
          alert(address + " not found");
        } else {
          gmap.setCenter(point, 13);
          var marker = new GMarker(point);
          gmap.addOverlay(marker);
        }
      }
    );
  }
}

function showmap(canvas, address) {
 gmap_showAddress(canvas, address);
}
