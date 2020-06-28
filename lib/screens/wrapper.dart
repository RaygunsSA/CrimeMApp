import 'package:crimap_flutter/providers/list_crime_locations.dart';
import 'package:crimap_flutter/screens/authenticate/sign_in.dart';
import 'package:crimap_flutter/screens/crime_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/authenticate/authenticate.dart';
//import '../screens/home/home.dart';
import '../models/user.dart';
import '../screens/disclose_crime_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    
    
    // return home or Authenticate user before proceding
    if (user == null){
      return SignIn();
    } else {
      return CrimeListScreen1();          
    }
    

  }
}