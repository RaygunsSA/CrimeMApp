import './place.dart';
import 'package:flutter/foundation.dart';

class SpecificEvent{
  final String username;
  final String id;
  final String crimetype;
  String description;
  final String date;
  final reporteddate;

  SpecificEvent({
    @required this.username,
    @required this.id,
    this.crimetype,
    this.description,
    this.date,
    @required this.reporteddate,
  });
}
