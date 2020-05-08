import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/providers/cheese_model.dart';
import 'views/home_view.dart';
import 'package:provider/provider.dart';
import 'models/user_location.dart';
import 'services/location_service.dart';

//main function runs the entire application
void main() => runApp(
  ChangeNotifierProvider( //provider which handles the Cheese state
    create: (context) => CheeseModel(),
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>( //Provider which helps track user location
      initialData: UserLocation(latitude: -6.642735, longitude: 39.1802449), //initial location
      create: (BuildContext context) => LocationService().locationStream,
      child:  MaterialApp(
        debugShowCheckedModeBanner: false, //turn off debug banner in app
        home: MyHomePage(),
      ),
    );
  }
}
