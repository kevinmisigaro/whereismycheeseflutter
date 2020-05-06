import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker cheeseMarker(LatLng point) => Marker(
    markerId: MarkerId(point.toString()),
    position: point,
    );
