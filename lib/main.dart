import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/disclose_crime_screen.dart';
import './screens/wrapper.dart';
import './services/auth.dart';
import './models/user.dart';
import './screens/crime_detail_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
          routes: {
            DiscloseCrimeScreen.routeName: (ctx)=>DiscloseCrimeScreen(),
            CrimeDetailScreen.routeName: (ctx)=>CrimeDetailScreen(),
          },
      ),
    );
  }
}
