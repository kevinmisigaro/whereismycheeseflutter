import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/cheese_model.dart';

class YourCheeseInfoDialog extends StatelessWidget {
  final MarkerId markerId;

  YourCheeseInfoDialog(this.markerId);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<CheeseModel>(context);

    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(children: <Widget>[
            Image.asset(
              'assets/icon/cheese_wheel.png',
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'This Cheese is Yours!',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(appState.displayMessage(markerId)),
            SizedBox(
              height: 15.0,
            ),
          ]),
        ),
      ),
    );
  }
}
