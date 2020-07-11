import 'package:flutter/foundation.dart';

import '../models/crime_description.dart';

class UserReportedCrimes with ChangeNotifier {
  List<CrimeDescription> _items = [];

  List<CrimeDescription> get items {
    return [..._items];
  }
}
