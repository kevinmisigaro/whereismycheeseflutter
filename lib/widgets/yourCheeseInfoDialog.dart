import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/cheese_service.dart';

//This Widget is for displaying info for cheese made by you
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
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: RaisedButton( //button to remove cheese from map
                  textColor: Colors.white,
                  color: Colors.orange[500],
                  onPressed: () {
                    appState.remove(markerId);
                    Navigator.of(context).pop();
                  },
                  child: Text('PICK UP CHEESE')),
            )
          ]),
        ),
      ),
    );
  }
}
