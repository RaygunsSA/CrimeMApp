
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
//import '../providers/list_crime_locations.dart';

class MapScreen extends StatefulWidget {
  final CrimeLocationAdress initialLocation;
  final bool isSelecting;

  MapScreen(     
    {this.initialLocation = const CrimeLocationAdress(latitude: -25.7402069, longitude:28.2098021 ), 
    this.isSelecting = false}
    );

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;
  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select location- Map Screen'),
        actions: <Widget>[ 
          // if (widget.isSelecting)
           IconButton(
              icon: Icon (Icons.check),
            onPressed:
               _pickedLocation == null 
             ? null 
               : (){
                 Navigator.of(context).pop(_pickedLocation);
               },
              ),
            ],
            
        ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
            ),
            zoom: 16,
          ),

          //this chaaaaes the marker look
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: _pickedLocation ==null ? null : {
            Marker(
              markerId: MarkerId('m1'),
              position: _pickedLocation,
            ),
          }  
        ),
    );
  }
}