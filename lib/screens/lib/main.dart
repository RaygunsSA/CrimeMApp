import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/map_screen.dart';
import './screens/auth_screen.dart';

import './providers/user_reported_crimes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserReportedCrimes>(
      create: (context) => UserReportedCrimes(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.blue[500],
            backgroundColor: Colors.blue[600],
            accentColor: Colors.purpleAccent,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.green,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            )),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return MapsScreen();
              }
              return AuthScreen();
            }),
      ),
    );
  }
}
