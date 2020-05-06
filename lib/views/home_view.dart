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
                  return CheeseInfoDialog(MarkerId(point.toString()));
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
