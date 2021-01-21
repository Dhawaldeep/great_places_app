import 'dart:io';

import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: null,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final places = await DBHelper.getData('user_places');
    _places = places
        .map(
          (e) => Place(
              id: e['id'],
              title: e['title'],
              image: File(e['image']),
              location: null),
        )
        .toList();
    notifyListeners();
  }
}
