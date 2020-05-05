import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cheese{
  final MarkerId id;
  String message;
  final Marker marker;
  bool hasMessage;
  bool isYours;

  Cheese({@required this.id, this.message, @required this.marker, this.hasMessage = false, this.isYours = false});
}