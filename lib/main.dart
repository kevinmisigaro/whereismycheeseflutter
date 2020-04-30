import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MapSampleState();
}

class MapSampleState extends State<MyHomePage> {
  List<Marker> allMarkers = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        allMarkers.add(
        Marker(
          markerId: MarkerId('myMarker'),
          draggable: false,
          position: LatLng(-6.643866, 39.18096),
          onTap: () {
            print('Marker Tapped');
          }
        )
    );
  }
  
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.643049, 39.182063),
    zoom: 15,
  );

  _handleTap(LatLng point) {
    setState(() {
      allMarkers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker'
        )
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('WhereIsMyCheese'),
        backgroundColor: Colors.orange[500],
      ),
      body: GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          markers: Set.from(allMarkers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        onLongPress: _handleTap,
        ),
    );
  }

}