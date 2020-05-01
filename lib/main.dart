import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/datamodels/user_location.dart';
import 'package:flutter_google_map_trial/services/location_service.dart';
import 'package:provider/provider.dart';
import 'views/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      );
  }
}
