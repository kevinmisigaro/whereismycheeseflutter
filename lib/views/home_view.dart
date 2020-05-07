import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/widgets/addCheeseDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/user_location.dart';
import '../providers/cheese_model.dart';
import '../widgets/yourCheeseInfoDialog.dart';
import '../widgets/cheeseInfoDialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  void _showNotifications() async {
    await _demoNotification();
  }

  Future<void> _demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel ID', 'channel name', 'channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker'
    );

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);
    
    await notifications.show(0, 'Check me!', 'You are near a cheese', platformChannelSpecifics, payload: 'test');
  }

  @override
  void initState() {
    super.initState();
//Notifications
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    settingsAndroid = AndroidInitializationSettings('cheese_logo');
    settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(settingsAndroid, settingsIOS);
    
    notifications.initialize(initializationSettings, onSelectNotification: onSelectNotification);

    //Custom image for marker
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/icon/cheese64.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  Future onSelectNotification(String payload) async {
    if(payload != null){
      print('Notification payload: $payload');
    }
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text('Check your nearest location for cheese'),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Okay'))
          ],
        )
    );
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text('Check your nearest location for cheese'),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Okay'))
          ],
            )
    );
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    final appState = Provider.of<CheeseModel>(context);

    Marker initialCheeseMarker(LatLng point) => Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        icon: pinLocationIcon,
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                if (appState.ifCheeseIsYours(MarkerId(point.toString()))) {
                  return YourCheeseInfoDialog(MarkerId(point.toString()));
                } else if (appState
                    .checkIfCheeseHasMessage(MarkerId(point.toString()))) {
                  return CheeseInfoDialog(MarkerId(point.toString()),
                      appState.displayMessage(MarkerId(point.toString())));
                } else {
                  return CheeseDialog(MarkerId(point.toString()));
                }
              });
        });

    return new Scaffold(
      appBar: AppBar(
        title: Text('WhereIsMyCheese'),
        backgroundColor: Colors.orange[500],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          _showNotifications();
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(userLocation.latitude, userLocation.longitude),
          zoom: 15,
        ),
        markers: Set.from(appState.cheese
            .map((x) => initialCheeseMarker(x.marker.position))
            .toList()),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onLongPress: (LatLng point) {
          setState(() {
            appState.add(initialCheeseMarker(point));
          });
        },
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
