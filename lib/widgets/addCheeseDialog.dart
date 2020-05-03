import 'package:flutter/material.dart';

Dialog addCheeseDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  child: Container(
    height: 300.0,
    width: 300.0,
    child: Column(
      children:<Widget>[
        Text('This is a test')
      ]
    ),
  ),
);