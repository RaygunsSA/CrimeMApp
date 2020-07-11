import 'package:crime_map_three/screens/report_crime_screen.dart';
import 'package:crime_map_three/widgets/mapMaker.dart';
import 'package:flutter/material.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MenuOptions {
  ReportCrime,
  MapScreen,
  EditCase,
  Filter,
  Logout,
}

class MapsScreen extends StatefulWidget {
  // final AuthService _auth = AuthService();
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapscreen'), actions: <Widget>[
        PopupMenuButton(
            onSelected: (MenuOptions selectedValue) {
              if (selectedValue == MenuOptions.Logout) {
                FirebaseAuth.instance.signOut();
              }
              if (selectedValue == MenuOptions.ReportCrime) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ReportCrimeScreen(),
                ));
                print("Mark Crime selected");
              }
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
                  PopupMenuItem(
                      child: Text('Report Crime'),
                      value: MenuOptions.ReportCrime),
                  PopupMenuItem(
                      child: Text('Map Screen'), value: MenuOptions.MapScreen),
                  PopupMenuItem(
                      child: Text('Edit Case'), value: MenuOptions.EditCase),
                  PopupMenuItem(
                      child: Text('Filter'), value: MenuOptions.Filter),
                  PopupMenuItem(
                      child: Text('Logout'), value: MenuOptions.Logout),
                ]),
      ]),

      body: Stack(
        children: <Widget>[
          MapMaker(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child:Icon(Icons.add),
      //   onPressed: (){
      //       Firestore.instance.collection('/users/hgIs4gz4eq6qj3eTHtFr/messages')
      //       .add({
      //           'text':'this was added by clicking the button'
      //       });
      //     }
      // ),
    );
  }
}

// class FireMap extends StatefulWidget {
//   @override
//   _FireMapState createState() => _FireMapState();
// }

// class _FireMapState extends State<FireMap> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//          GoogleMap(
//            initialCameraPosition: CameraPosition(
//              target: LatLng(24.142, -110.321),
//              zoom: 15
//              )
//             )

//       ],

//     );
//   }
// }
