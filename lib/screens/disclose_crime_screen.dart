// this is the same as "report a new crime" but for legal implications, not calling it report
//here the user can disclose all information regarding a particular crime
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';


//import 'package:path_provider/path_provider.dart';

import '../services/location_input.dart';
import '../widgets/image_input.dart';
import '../providers/list_crime_locations.dart';
//import '../widgets/select_crime_dropd.dart';


class DiscloseCrimeScreen extends StatefulWidget {
  static const routeName = '/disclose-location';

  @override
  _DiscloseCrimeScreenState createState() => _DiscloseCrimeScreenState();
}

class _DiscloseCrimeScreenState extends State<DiscloseCrimeScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  CrimeLocationAdress _pickedLocation;


  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng){
    _pickedLocation = CrimeLocationAdress(latitude: lat, longitude: lng);
  }

  void _savePlace(){        //determines if reported crime form is submitable
    if (_titleController.text.isEmpty|| 
    _pickedImage == null ||
    _pickedLocation == null){
        print('Error, title controller is empty');
        return;
    }
    Provider.of<CrimeLocation>(context, listen: false)
        .addPlace(_titleController.text,_pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report a crime'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                     children: <Widget>[
                                   //currently using Textfield but look into using TextformFiek
                       TextField(       
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                        ),
                                   // to change o a dropdown menu
                        RaisedButton(
                          child: Text('Dropdown!'),
                        onPressed: (){
                              print('Dropdown');
                                    // SelectCrimeDropD();
                          },
                        ),
                        SizedBox(height: 10,),
                        ImageInput(_selectImage),
                        SizedBox(height:10,),
                        LocationInput(),
                     ],
                  ),
                ),
            ),
            ),
          Text('Report a crime'),
           RaisedButton.icon(
            icon: Icon(Icons.edit_location),
            label: Text('Mark Location'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
             )
           ],
         ),
       );
     }
}