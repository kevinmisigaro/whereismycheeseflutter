import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Cheese object

//Contains:
class Cheese{
  final MarkerId id;    //id to differentiate between different cheese
  String message;       //message contained in cheese
  final Marker marker;  //marker which points where the cheese is in the GPS
  bool hasMessage;      //boolean to check if cheese has message
  bool isYours;         //boolean to check if cheese is made by user

  Cheese({@required this.id, this.message, @required this.marker, this.hasMessage = false, this.isYours = false,});
}