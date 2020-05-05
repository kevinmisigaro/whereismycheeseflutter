import 'package:flutter/foundation.dart';
import '../models/cheese.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheeseModel extends ChangeNotifier {
  final List<Cheese> _cheese = [];
  final List<Marker> _cheeseMarkers = [];

  List<Marker> get cheese => _cheeseMarkers;

  void add(Marker marker) {
    //
    _cheese.add(Cheese(id: marker.markerId, marker: marker));
    _cheeseMarkers.add(marker);
    notifyListeners();
  }

  void sendMessage(MarkerId id, String message) {
    //add message for marker which matches the id

    //first check for the Cheese value which matches the id passed on the argument
    var result = _cheese.firstWhere((x) => x.id == id);
    //assign message string to cheese value
    result.message = message;
    //turn boolean to cheese having message to true
    result.hasMessage = !result.hasMessage;
    notifyListeners();
  }

  bool getOneCheese(MarkerId markerId) {
    //get value of cheese which matches the markerId passed in argument
    var result = _cheese.firstWhere((x) => x.id == markerId);
    //return boolean if cheese has message or not
    return result.hasMessage;
  }

  void remove(Cheese cheese) {
    //remove cheese
    notifyListeners();
  }
}
