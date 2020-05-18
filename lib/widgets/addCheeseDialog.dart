import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'cheese_form.dart';

//Widget which holds form to add to newly created cheese
class CheeseDialog extends StatelessWidget {
  final MarkerId markerId;
  final Function notificationFunction;

  //Cheese dialog takes in markerId and notification function to pass down the widget tree to the cheese form
  CheeseDialog(this.markerId, this.notificationFunction);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 280.0,
        width: 300.0,
        child: Column(children: <Widget>[
          //form to add message to cheese
          CheeseForm(markerId, notificationFunction)
        ]),
      ),
    );
  }
}
