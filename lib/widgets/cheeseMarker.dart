import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/services/cheese_service.dart';
import 'package:flutter_google_map_trial/widgets/addCheeseDialog.dart';
import 'package:flutter_google_map_trial/widgets/cheeseInfoDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CheeseMarker extends StatefulWidget {

  LatLng point;

  CheeseMarker(this.point);

  @override
  State<StatefulWidget> createState() {
    return _CheeseMarkerObjectState();
  }
}

class _CheeseMarkerObjectState extends State<CheeseMarker>{

  BitmapDescriptor pinLocationIcon;

@override
  void initState() {
    super.initState();

        //Custom image for marker
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/icon/cheese64.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<CheeseModel>(context);

    // return Marker(
    //     markerId: MarkerId(widget.point.toString()),
    //     position: widget.point,
    //     icon: pinLocationIcon,
    //     onTap: () {
    //       showDialog(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return appState
    //                     .checkIfCheeseHasMessage(MarkerId(widget.point.toString()))
    //                 ? CheeseInfoDialog(MarkerId(widget.point.toString()),
    //                     appState.displayMessage(MarkerId(widget.point.toString())))
    //                 : CheeseDialog(
    //                     MarkerId(widget.point.toString()));
    //           });
    //     });
  }
}