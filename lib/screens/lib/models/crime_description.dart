import 'package:flutter/foundation.dart';

class CrimeLocation {
  final double latitude;
  final double longitude;
  final String address;

  const CrimeLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

//these are the properties that make up a crime description
class CrimeDescription {
  final String id;
  final String crimeType;
  final CrimeLocation location;
  DateTime dateOfCrime;

  CrimeDescription({
    @required this.id,
    @required this.crimeType,
    //@required
    this.location,
    @required this.dateOfCrime,
  });
}
