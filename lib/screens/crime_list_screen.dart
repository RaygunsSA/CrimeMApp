//import 'package:crimap_flutter/screens/disclose_crime_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../providers/list_crime_locations.dart';
import './crime_detail_screen.dart';

class CrimeListScreen extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.blue[100],     
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Crime List Screen'),
        actions: <Widget>[
          FlatButton.icon(
             icon: Icon(Icons.add),
              label: Text('Logout'),
               onPressed: () async{
                 await _auth.signOut();
               },
          )
        ],
      ),
       body: FutureBuilder( 
          future: Provider.of<CrimeLocation>(context, listen: false)
          .fetchAndSetPlaces(),         
          builder: (ctx, snapshot) => snapshot.connectionState ==
           ConnectionState.waiting 
           ? Center (
              child: CircularProgressIndicator(),
             )
             :Consumer<CrimeLocation>(
             child: Center(
               child: Text('No Crime Locations reported yet'),
             ) ,
             builder:(ctx, crimeLocations, ch) =>
             crimeLocations.items.length <= 0
              ? ch: 
             ListView.builder(
                itemCount: crimeLocations.items.length,
                itemBuilder: (ctx,i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                       crimeLocations.items[i].image,
                        ),
                      ),
                  title: Text(crimeLocations.items[i].title),  
                  subtitle: Text(crimeLocations.items[i].location.address),
                  onTap: (){
                     Navigator.of(context).pushNamed(
                       CrimeDetailScreen.routeName,
                       arguments: crimeLocations.items[i].id,
                       );
                     },
                  ),
                ),
              ),
        ), 
       );           
  }
}