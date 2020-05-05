import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/widgets/addCheeseDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/user_location.dart';
import '../providers/cheese_model.dart';
import '../widgets/yourCheeseInfoDialog.dart';
import '../widgets/cheeseInfoDialog.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MapSampleState();
}

class MapSampleState extends State<MyHomePage> {
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/icon/cheese64.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    final appState = Provider.of<CheeseModel>(context);
    print('Application is built');
    return new Scaffold(
      appBar: AppBar(
        title: Text('WhereIsMyCheese'),
        backgroundColor: Colors.orange[500],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(userLocation.latitude, userLocation.longitude),
          zoom: 15,
        ),
        markers: Set.from(appState.cheese),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onLongPress: (LatLng point) {
          setState(() {
            appState.add(Marker(
              markerId: MarkerId(point.toString()),
              position: point,
              icon: pinLocationIcon,
              // infoWindow: InfoWindow(title: 'I am a marker'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => (appState
                            .ifCheeseIsYours(MarkerId(point.toString())))
                        ? YourCheeseInfoDialog()
                        : ((appState.getOneCheese(MarkerId(point.toString())))
                            ? CheeseInfoDialog()
                            : CheeseDialog(
                                markerId: MarkerId(point.toString()),
                              )));
              },
            ));
          });
        },
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
