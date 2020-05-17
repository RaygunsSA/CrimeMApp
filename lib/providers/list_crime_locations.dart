// this service is to list and maintain crime locations
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../services/location_helper.dart';
import '../services/db_helper.dart'; 

class CrimeLocation with ChangeNotifier {
  List<Place> _items =[];

  List<Place> get items{      // getting copy to prevent changing Original
    return _items;
  }
  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future <void> addPlace(
    String pickedTitle,
     File pickedImage,
     CrimeLocationAdress pickedLocation,
    ) async{
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = CrimeLocationAdress(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
      );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    
    //TODO ad type of crime and date to db  
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
      });
    }
    Future<void> fetchAndSetPlaces() async{
      final dataList = await DBHelper.getData('places');
      _items = dataList.map((item)=> Place(
        id: item['id'],
        title: item['title'],
        image:File(item['image']),
        location: CrimeLocationAdress(
          latitude: item['loc_lat'],
          longitude: item['loc_lng'],
          address: item['address'],
        ),
        )
      ).toList();
    notifyListeners();
    }
}