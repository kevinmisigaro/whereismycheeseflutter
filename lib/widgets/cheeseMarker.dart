import 'package:google_maps_flutter/google_maps_flutter.dart';

//geolocation marker for cheese

//takes latitude and longitude point and converts it to a marker to be stored into a cheese
Marker cheeseMarker(LatLng point) => Marker(
    markerId: MarkerId(point.toString()),
    position: point,
    );
