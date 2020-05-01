import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/datamodels/user_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MapSampleState();
}

class MapSampleState extends State<MyHomePage> {
  BitmapDescriptor pinLocationIcon;
  List<Marker> allMarkers = [];

  // Location location = Location();
  // Map<String, double> currentLocation;

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

  _handleTap(LatLng point) {
    setState(() {
      allMarkers.add(Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          icon: pinLocationIcon,
          infoWindow: InfoWindow(title: 'I am a marker')));
    });
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
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
        markers: Set.from(allMarkers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onLongPress: _handleTap,
      ),
    );
  }
}
