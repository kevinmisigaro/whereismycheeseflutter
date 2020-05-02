import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'package:provider/provider.dart';
import 'models/user_location.dart';
import 'services/location_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
