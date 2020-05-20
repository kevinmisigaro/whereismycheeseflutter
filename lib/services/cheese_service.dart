import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/cheese.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheeseModel extends ChangeNotifier {

  //list of cheese
  final List<Cheese> _cheese = [];

//getter for List of cheese
  List<Cheese> get cheese => _cheese;

//function to add Cheese
  void add(Marker marker, String message) {
    _cheese.add(Cheese(id: marker.markerId, marker: marker, message: message, isYours: true, hasMessage: true ));
    notifyListeners();
  }

//function to add message to newly created cheese
  void sendMessage(MarkerId id, String message) {
    //add message for marker which matches the id

    //first check for the Cheese value which matches the id passed on the argument
    var result = _cheese.firstWhere((x) => x.id == id);
    //assign message string to cheese value
    result.message = message;
    
    result.isYours = !result.isYours;
    result.hasMessage = !result.hasMessage;
    notifyListeners();
  }

  //get latitude and longitude point from marker ID
  LatLng getLatLng(MarkerId id){
    //first check for the Cheese value which matches the id passed on the argument
    var result = _cheese.firstWhere((x) => x.id == id);
    return result.marker.position;
  }


//function to check if cheese has message
  bool checkIfCheeseHasMessage(MarkerId markerId) {
    //get value of cheese which matches the markerId passed in argument
    var result = _cheese.firstWhere((x) => x.id == markerId);
    //return boolean if cheese has message or not
    return result.hasMessage;
  }

//function to display message inside cheese
  String displayMessage(MarkerId markerId) {
    var result = _cheese.firstWhere(
      (x) => x.id == markerId,
    );
    return result.message;
  }

//function to check if cheese is made by user or not
  bool ifCheeseIsYours(MarkerId markerId) {
    var result = _cheese.firstWhere((x) => x.id == markerId);
    return result.isYours;
  }

//function to remove cheese
  void remove(MarkerId markerId) {
    _cheese.removeWhere((x) => x.id == markerId);
    notifyListeners();
  }
}