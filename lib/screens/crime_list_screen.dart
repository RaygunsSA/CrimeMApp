import 'package:crimap_flutter/screens/disclose_crime_screen.dart';
import 'package:crimap_flutter/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth.dart';
import '../providers/list_crime_locations.dart';
import './crime_detail_screen.dart';

enum MenuOptions{
  ReportCrime,
  EditCase,
  Filter,
  Logout,
}

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
       // backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0.0,
          title: Text('Crime List ScreenB3'),
           actions: <Widget>[
            PopupMenuButton(
              onSelected: (MenuOptions selectedValue){
                if (selectedValue == MenuOptions.Logout){
                   _auth.signOut();
                }
                if (selectedValue == MenuOptions.ReportCrime){
                    Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (ctx)=> DiscloseCrimeScreen(
                         ),
                       )
                    );
                    print("Mark Crime selected");
                 }
              }, 
              
               icon:Icon(Icons.more_vert,),
               itemBuilder: (_) =>[
                 PopupMenuItem(child: Text('Report Crime'), value:MenuOptions.ReportCrime),
                 PopupMenuItem(child: Text('Edit Case'), value:MenuOptions.EditCase),
                 PopupMenuItem(child: Text('Filter'), value:MenuOptions.Filter),
                 PopupMenuItem(child: Text('Logout'), value:MenuOptions.Logout),
               ] 

            ), 
          ]  
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
                 label: Text('Database9'),
                   onPressed: (){
                     Firestore.instance
                     .collection('/crime_reports/1C5EAVfchvsDfbo7JKui/crime')
                     .snapshots().listen((data) {
                      data.documents.forEach((document){
                        print(document['text']);
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