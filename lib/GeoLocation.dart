import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

class GeoLocation extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {

  String city,lat,longi;
  bool toShow=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  getUserLocation() async {
    LocationData myLocation;
    String error;
    Location location = new Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    var currentLocation = myLocation;
    lat=myLocation.latitude.toString();
    longi=myLocation.longitude.toString();
    final coordinates = new Coordinates(
        myLocation.latitude, myLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    city="${first.addressLine}";
    setState(() {
     // city="${first.addressLine}";
      toShow=false;
    });
    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Do you really want to exit the app?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: ()=>Navigator.pop(context,false),
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: ()=>Navigator.pop(context,true),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("GeoLocation",style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              toShow?Container():Text(
                "Your Current Location",
                style:TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                ),
              ),

              SizedBox(height: 10.0,),

              toShow?Text(
                "Getting Your Location...",
                style:TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.grey[600],
                    fontSize: 16.0
                ),
              ):Text(
                city,
                style:TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.grey[600],
                  fontSize: 16.0
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10.0,),

              toShow?CircularProgressIndicator():Container(),
            ],
          ),
        ),
      ),
    );
  }
}
