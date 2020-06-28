import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/map_screen.dart';
import './location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput({
    this.onSelectPlace
  });
 
 @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  
  String _previewImageUrl;                //this is a preview image of the location on map

  void _showPreview(double lat, double lng)
  {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude:lat,
          longitude: lng,
        ); 
      setState(() {
        _previewImageUrl = staticMapImageUrl;
        });
  }
                                          //user selects current location
  Future<void> _getCurrentUserLocation() async {
    try{
      final locData = await Location().getLocation();   
        print(locData.latitude);
        print(locData.longitude);  
        _showPreview(locData.latitude, locData.longitude);
      // final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      //   latitude:locData.latitude,
      //   longitude:locData.longitude,
      //   );
   
      widget.onSelectPlace(locData.latitude,locData.longitude);
    }catch(error){
      return;
    }
  }  
                                            //user selects location on map
  Future<void> _selectOnMap() async{
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
          ),
        ),
     );
     if (selectedLocation == null){
       return;
     }
     print(selectedLocation.latitude);
      _showPreview(selectedLocation.latitude,selectedLocation.longitude);
      widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width:1,
              color: Colors.grey,
              )
            ),
          child: _previewImageUrl == null? Text(
            'No Location Chosen',
             textAlign: TextAlign.center) : 
             Image.network(
               _previewImageUrl,
               fit:BoxFit.cover,
               width: double.infinity
               ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location2'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,             
              ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            )
          ],)
      ],
    );
  }
}