import 'dart:async';

import 'package:location/location.dart';
import '../models/user_location.dart';

class LocationService {

  UserLocation _currentLocation;

  Location location = Location();

  //location broadcast stream
  StreamController<UserLocation> _locationController = StreamController<UserLocation>.broadcast();

  LocationService() {
    // Request permission to use location
   location.requestPermission().then((granted) {
     if (granted != null) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
     }
   });
  }

//getter for location stream
  Stream<UserLocation> get locationStream => _locationController.stream;

//function to get user current location
  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}





