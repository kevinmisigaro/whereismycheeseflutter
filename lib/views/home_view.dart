import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/widgets/addCheeseDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/user_location.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MapSampleState();
}

class MapSampleState extends State<MyHomePage> {
  BitmapDescriptor pinLocationIcon;
  List<Marker> allMarkers = [];

  //static LatLng _center = LatLng(-6.642735, 39.1802449);

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
        // infoWindow: InfoWindow(title: 'I am a marker'),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => addCheeseDialog);
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    print(
        'Location: Lat${userLocation.latitude}, Long${userLocation.longitude}');
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
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
