import 'package:crimap_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/list_crime_locations.dart';
import '../screens/map_screen.dart';


class CrimeDetailScreen extends StatelessWidget {
  static const routeName = '/crime-detail';
  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<CrimeLocation>(context, listen: false).findById(id);
    return Scaffold(
     
      body: Column(children: <Widget>[
        
        Container(
         height: 250,
         width: double.infinity,
         child: Image.file(
           selectedPlace.image,
           fit:BoxFit.cover,
           width: double.infinity,
           ), 
         ),
        SizedBox(height:10,),
        Text(
          selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),  
        ), 
        SizedBox(height:10,),
        FlatButton(child: Text('Edit Crime Details - View on Map '),
        textColor: Theme.of(context).primaryColor ,
        onPressed:(){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx)=> MapScreen(
                initialLocation: selectedPlace.location,
                isSelecting: false,
              ),
            ),
          ); 
        } ,)
      ],)
    );
  }
}