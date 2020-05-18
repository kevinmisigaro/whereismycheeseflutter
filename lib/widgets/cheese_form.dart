import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/models/user_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/cheese_service.dart';
import 'package:latlong/latlong.dart' as lat; //function to help calculate distance between two geo-locations

class CheeseForm extends StatefulWidget {
  final MarkerId markerId;
  final Function notificationFunction;

  CheeseForm(this.markerId, this.notificationFunction);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheeseFormState();
  }
}

class CheeseFormState extends State<CheeseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    var appState = Provider.of<CheeseModel>(context);

    final lat.Distance distance = new lat.Distance();

    var userLocation = Provider.of<UserLocation>(context); //get current user location

    final LatLng position = appState.getLatLng(widget.markerId); //get marker LatLng from marker ID using the cheese service

    //Calculate distance between all markers and user location
    void calculateDistance(latitude, longitude) {
      final double meter = distance(
          new lat.LatLng(userLocation.latitude, userLocation.longitude),
          new lat.LatLng(latitude, longitude));

      //if distance is less or equal to 50 meters, display notification
      if (meter <= 50) {
        widget.notificationFunction(); //fires the function passed down the widget tree to display notification
      }
    }

    // TODO: implement build
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //close button
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),

              //text input field
              TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 1.0),
                  ),
                  hintText: 'Leave a cheesy note..',
                ),
                controller: _textEditingController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 7.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: RaisedButton(
                  //submit button
                  color: Colors.orange,
                  textColor: Colors.white,
                  onPressed: () {
                    //function call which adds the text to the cheese
                    appState.sendMessage(
                        widget.markerId, _textEditingController.text);
                    Navigator.of(context).pop();
                    calculateDistance(position.latitude, position.longitude);
                  },
                  child: Text('Save Cheese!'),
                ),
              )
            ],
          ),
        ));
  }
}
