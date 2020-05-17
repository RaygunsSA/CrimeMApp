//here the user can mark a crime at a location
//this is should only be available for Signed in Users
import 'dart:io';
//import 'package:crimap_flutter/screens/crime_list_screen.dart';
import 'package:flutter/foundation.dart';

class CrimeLocationAdress{ 
  final String address;               //this Class id for creating location info 2b used in Place Class
  final double latitude;
  final double longitude;
  
  const CrimeLocationAdress({
    this.address,
    @required this.latitude,
    @required this.longitude,
  });
}

class Place {
  final String id;
  final String title;
  final CrimeLocationAdress location;        // 
  final File image;          //images shouldbe optional

  Place ({
    @required this.image,
    @required this.id,
    @required this.title,
    @required this.location,
  });

}