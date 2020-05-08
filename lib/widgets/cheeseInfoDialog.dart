import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/cheese_model.dart';

//this Widget is for cheese from other sources
class CheeseInfoDialog extends StatefulWidget {
  final MarkerId markerId;
  final String message;

  CheeseInfoDialog(this.markerId, this.message);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CheeseInfoDialogState();
  }
}

class _CheeseInfoDialogState extends State<CheeseInfoDialog> {
  
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
              'Cheese is Discovered!',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
                widget.message //text which shows cheese message
            ),
            SizedBox(
              height: 15.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: RaisedButton( //button to remove cheese from map
                  textColor: Colors.white,
                  color: Colors.orange[500],
                  onPressed: () {
                    appState.remove(widget.markerId);
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
