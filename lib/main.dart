import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

import 'GeoLocation.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GeoLocation",
      theme: ThemeData(
        primaryColor: Colors.blueGrey[500],
        primaryColorDark: Colors.blueGrey[800],
        accentColor: Colors.grey[300]
      ),
      home: GeoLocation(),
    );
  }
}

