import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/widgets/addCheeseDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/user_location.dart';
import '../services/cheese_service.dart';
import '../widgets/yourCheeseInfoDialog.dart';
import '../widgets/cheeseInfoDialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:latlong/latlong.dart' as lat;

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

//function which displays notification on phone
  void _showNotifications() async {
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

    print('init state is called here');
  }

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

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    //provider for user location
    var userLocation = Provider.of<UserLocation>(context);

    //provider for cheese list
    final appState = Provider.of<CheeseModel>(context);

    final lat.Distance distance = new lat.Distance();

    //Calculate distance between all markers and user location
    void calculateDistance(latitude, longitude) {
      final double meter = distance(
          new lat.LatLng(userLocation.latitude, userLocation.longitude),
          new lat.LatLng(latitude, longitude));

      //if distance is greater or equal to 50 meters, display notification
      if (meter >= 50) {
        _showNotifications();
      }
    }

    // void checkDistance() {
    //   appState.cheese
    //          .map((x) => x.marker.position)
    //          .toList()
    //          .forEach((y) => calculateDistance(y.latitude, y.longitude));
    // }

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

        //returns all markers from cheese
        markers: Set.from(appState.cheese
            .map((x) => initialCheeseMarker(x.marker.position))
            .toList()),

        //when map is created, run this function
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        //on long press on google map, cheese is added
        onLongPress: (LatLng point) {
          setState(() {
            appState.add(initialCheeseMarker(point));
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CheeseDialog(MarkerId(point.toString()));
              });
        },
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
