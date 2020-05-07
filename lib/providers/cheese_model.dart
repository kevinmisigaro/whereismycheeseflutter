import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/cheese.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/cheeseMarker.dart';

class CheeseModel extends ChangeNotifier {
  final List<Cheese> _cheese = [
    Cheese(
        id: MarkerId(LatLng(-6.642875, 39.182591).toString()),
        marker: cheeseMarker(LatLng(-6.642875, 39.182591)),
        message: 'Rick and Morty is a great show',
        hasMessage: true),
    Cheese(
        id: MarkerId(LatLng(-6.643242, 39.181389).toString()),
        marker: cheeseMarker(LatLng(-6.643242, 39.181389)),
        message: 'Bojack Horseman is the best show',
        hasMessage: true),
  ];

  List<Cheese> get cheese => _cheese;

  void add(Marker marker) {
    _cheese.add(Cheese(id: marker.markerId, marker: marker));
    notifyListeners();
  }

  void addInitialMarkers(Marker marker) {
    _cheese.add(Cheese(id: marker.markerId, marker: marker));
  }

  void sendMessage(MarkerId id, String message) {
    //add message for marker which matches the id

    //first check for the Cheese value which matches the id passed on the argument
    var result = _cheese.firstWhere((x) => x.id == id);
    //assign message string to cheese value
    result.message = message;
    //turn boolean to cheese having message to true
    result.isYours = !result.isYours;
    result.hasMessage = !result.hasMessage;
    notifyListeners();
  }

  bool checkIfCheeseHasMessage(MarkerId markerId) {
    //get value of cheese which matches the markerId passed in argument
    var result = _cheese.firstWhere((x) => x.id == markerId);
    //return boolean if cheese has message or not
    return result.hasMessage;
  }

  String displayMessage(MarkerId markerId) {
    var result = _cheese.firstWhere((x) => x.id == markerId,);
    return result.message;
  }

  bool ifCheeseIsYours(MarkerId markerId) {
    var result = _cheese.firstWhere((x) => x.id == markerId);
    return result.isYours;
  }

  void remove(MarkerId markerId) {
   _cheese.removeWhere((x) => x.id == markerId);
    notifyListeners();
  }
}
