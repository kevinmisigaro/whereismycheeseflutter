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
      debugShowCheckedModeBanner: false,
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
  BitmapDescriptor pinLocationIcon;
  List<Marker> allMarkers = [];

  @override
   void initState() {
     super.initState();
      BitmapDescriptor.fromAssetImage(
         ImageConfiguration(devicePixelRatio: 2.5),
         'assets/icon/cheese64.png').then((onValue) {
            pinLocationIcon = onValue;
         });
   }
  
  // @override
  // void initState() {
  //   super.initState();
  //       allMarkers.add(
  //       Marker(
  //         markerId: MarkerId('myMarker'),
  //         draggable: false,
  //         position: LatLng(-6.643866, 39.18096),
  //         onTap: () {
  //           print('Marker Tapped');
  //         }
  //       )
  //   );
  // }
  
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
        icon: pinLocationIcon,
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