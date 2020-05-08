import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/providers/cheese_model.dart';
import 'views/home_view.dart';
import 'package:provider/provider.dart';
import 'models/user_location.dart';
import 'services/location_service.dart';

//main function runs the entire application
void main() => runApp(
  //provider which handles the Cheese state
  ChangeNotifierProvider( 
    create: (context) => CheeseModel(),
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider which helps track user location
    return StreamProvider<UserLocation>( 
      initialData: UserLocation(latitude: -6.642735, longitude: 39.1802449), //initial location
      create: (BuildContext context) => LocationService().locationStream,
      child:  MaterialApp(
        //turn off debug banner in app
        debugShowCheckedModeBanner: false, 
        home: MyHomePage(),
      ),
    );
  }
}
