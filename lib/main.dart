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
      initialData: UserLocation(latitude: -6.7726935, longitude: 39.2196418),
      create: (BuildContext context) => LocationService().locationStream,
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
