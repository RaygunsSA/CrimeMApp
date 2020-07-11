import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MapsScreen(),
    ));
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: 250,
          width: double.infinity,
          child: _previewImageUrl == null
              ? GoogleMap(
                  mapType: MapType.normal, // Todo create Map_selection Option
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-25.7428214, 28.1742587),
                    zoom: 10,
                  ),
                  myLocationEnabled: true,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            label: Text('Current Location'),
            onPressed: _getCurrentUserLocation,
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.location_on),
          ),
          FlatButton.icon(
            label: Text('Select on Map'),
            onPressed: _selectOnMap,
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.map),
          )
        ],
      )
    ]);
  }
}
