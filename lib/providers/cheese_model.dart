import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/cheese.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/cheeseMarker.dart';

class CheeseModel extends ChangeNotifier {

  //list of cheese
  final List<Cheese> _cheese = [
    //cheese close to Dar es Salaam
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

    //cheese close to WIMT Cape Town office
    Cheese(
      id: MarkerId(LatLng(-33.914306, 18.416628).toString()),
      marker: cheeseMarker(LatLng(-33.914306, 18.416628)),
      message:
          'This marker was set purposefully to be close to the WIMT office',
      hasMessage: true,
    ),
    Cheese(
      id: MarkerId(LatLng(-33.913494, 18.416721).toString()),
      marker: cheeseMarker(LatLng(-33.913494, 18.416721)),
      message:
          'This is another marker set purposefully close to the office for demo purposes.',
      hasMessage: true,
    ),
  ];

//getter for cheese
  List<Cheese> get cheese => _cheese;

//function to add Cheese
  void add(Marker marker) {
    _cheese.add(Cheese(id: marker.markerId, marker: marker));
    notifyListeners();
  }

//obselete for now
  void addInitialMarkers(Marker marker) {
    _cheese.add(Cheese(id: marker.markerId, marker: marker));
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

//function to check if cheese has message
  bool checkIfCheeseHasMessage(MarkerId markerId) {
    //get value of cheese which matches the markerId passed in argument
    var result = _cheese.firstWhere((x) => x.id == markerId);
    //return boolean if cheese has message or not
    return result.hasMessage;
  }

//funtion to display message inside cheese
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
