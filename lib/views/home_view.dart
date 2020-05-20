import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/widgets/addCheeseDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/user_location.dart';
import '../services/cheese_service.dart';
import '../widgets/cheeseInfoDialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:latlong/latlong.dart'
    as lat; //function to help calculate distance between two geo-locations

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MapSampleState();
}

class MapSampleState extends State<MyHomePage> {
  BitmapDescriptor pinLocationIcon;

  FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  var settingsAndroid;
  var settingsIOS;
  var initializationSettings;

  Marker markerToCheck;
  List markerList = [];

  @override
  void initState() {
    super.initState();

    //Following code handles notifications
    settingsAndroid = AndroidInitializationSettings('cheese_logo');
    settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings =
        InitializationSettings(settingsAndroid, settingsIOS);

    notifications.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    //Custom image for marker
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/icon/cheese64.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  //notification message display for android
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    }
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text('Check your nearest location for cheese'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  //notification message display for IOS
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text('Check your nearest location for cheese'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  //function which displays notification on phone
  void showNotifications() async {
    await _demoNotification();
  }

  Future<void> _demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel ID', 'channel name', 'channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await notifications.show(
        0, 'Check me!', 'You are near a cheese', platformChannelSpecifics,
        payload: 'test');
  }

  Completer<GoogleMapController> _controller = Completer();

  final lat.Distance distance = new lat.Distance();

  @override
  Widget build(BuildContext context) {
    //provider for user location with latitude and longitude
    var userLocation = Provider.of<UserLocation>(context);

    //provider for cheese list
    final appState = Provider.of<CheeseModel>(context);

    //Calculate distance between newly created marker and user location
    double calculateDistance(latitude, longitude) {
      final double meter = distance(
          new lat.LatLng(userLocation.latitude, userLocation.longitude),
          new lat.LatLng(latitude, longitude));

      return meter;
    }

    checkIfCloseToUserLocation() {
        appState.cheese.forEach((element) {
          double meter = calculateDistance(element.marker.position.latitude,
              element.marker.position.longitude);
          if (!markerList.contains(element.marker)) {
            if (meter <= 50) {
              setState(() {
                markerList.add(element.marker);
              });
              showNotifications();
            } else {
              return null;
            }
          } else {
            if (meter <= 50) {
              return null;
            } else {
              setState(() {
                markerList.remove(element.marker);
              });
            }
          }
        });
    }

    checkIfCloseToUserLocation();

    //setting how the marker in Google Map will appear.
    Marker initialCheeseMarker(LatLng point) => Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        icon: pinLocationIcon,
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CheeseInfoDialog(MarkerId(point.toString()),
                        appState.displayMessage(MarkerId(point.toString())));
              });
        });

    return new Scaffold(
      appBar: AppBar(
        title: Text('WhereIsMyCheese'),
        backgroundColor: Colors.orange[500],
      ),
      body: GoogleMap(
        //Google map background
        mapType: MapType.normal, //normal map type set
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          //initial camera position set to user location
          target: LatLng(userLocation.latitude, userLocation.longitude),
          zoom: 15,
        ),

        //returns all markers from cheese in a list, which then is displayed in the map
        markers: Set.from(appState.cheese
            .map((x) => initialCheeseMarker(x.marker.position))
            .toList()),

        //when map is created, this Google Map controller is run
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        //on long press on at any point of the Google map, the cheese is added and Cheese dialog opens to add input
        onLongPress: (LatLng point) {
          // setState(() {
          //   appState.add(initialCheeseMarker(point));
          // });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                //Cheese Dialog class takes a newly created marker Id and show notifications function to as to be passed down the widget tree
                //the marker id will in assigning the new message to the newly created marker
                //the show notifications function will be used in a check, if true, will call back the function so that it can display a widget in the
                //HomePage() context
                return CheeseDialog(
                    point, initialCheeseMarker);
              });
        },
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
