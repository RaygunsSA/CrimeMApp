import 'package:crimap_flutter/screens/disclose_crime_screen.dart';
import 'package:crimap_flutter/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth.dart';
import '../providers/list_crime_locations.dart';
import './crime_detail_screen.dart';

  class CrimeListScreen1 extends StatefulWidget {
  @override
  _CrimeListScreen1State createState() => _CrimeListScreen1State();
}

class _CrimeListScreen1State extends State<CrimeListScreen1> {
     final AuthService _auth = AuthService();

    @override
    Widget build(BuildContext context) {
      return 
      ChangeNotifierProvider<CrimeLocation>(
          create: (context) =>CrimeLocation(),
          child: Consumer<CrimeLocation>(
                  builder: (context, provider, child) =>Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          title: Text('Crime List ScreenA9'),
           actions: <Widget>[
            FlatButton.icon(
               icon:Icon(Icons.add),
               label: Text('Logout'),
               onPressed:()async{
                 await _auth.signOut();
               },
               )
           ],
          ),
       body: Column(
        children: <Widget>[ 
          Expanded(
                child: FutureBuilder( 
            future: Provider.of<CrimeLocation>(context, listen: false)
            .fetchAndSetPlaces(),         
            builder: (ctx, snapshot) => snapshot.connectionState ==
             ConnectionState.waiting 
             ? Center (
                child:MapScreen(),          //this runs the map
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
                      //images from memory
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
          ),  
        
             Row(
               children: <Widget>[
                 FlatButton.icon(
                 icon: Icon(Icons.edit_location),
                 label: Text('Report a Crime'),
                 onPressed: (){
                    Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (ctx)=> DiscloseCrimeScreen(
                        ),
                       )
                    );
                    print("Mark Crime selected");
                 },
            //  elevation: 0,
                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                 color: Theme.of(context).accentColor,
                 ),
                FlatButton.icon(
                 icon: Icon(Icons.edit_attributes),
                 label: Text('Database8'),
                   onPressed: (){
                     Firestore.instance
                     .collection('CrimeList/g4X4fULKcsM0ufXurIPQ/CrimeID')
                     .snapshots().listen((data) {
                      data.documents.forEach((document){
                        print(document['CrimeID']);
                      });
                    print('Database selected');   
                      });
                   }
               ), 
               ],
             ),
        ]  
             )
             ),
           ),
         );    
  }
}