import 'package:flutter/material.dart';
import 'package:flutter_google_map_trial/models/user_location.dart';
import 'package:flutter_google_map_trial/widgets/cheeseInfoDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/cheese_service.dart';
import 'package:latlong/latlong.dart'
    as lat; //function to help calculate distance between two geo-locations

class CheeseForm extends StatefulWidget {
  final LatLng marker;
  final Function markerMaker;

  CheeseForm(this.marker, this.markerMaker);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheeseFormState();
  }
}

class CheeseFormState extends State<CheeseForm> {

    BitmapDescriptor pinLocationIcon;

  final _formKey = GlobalKey<FormState>();

  //controller placed before build so as to not cause constant rebuilding and disappearing of text
  final TextEditingController _textEditingController = TextEditingController();

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
    //call app state so as to get functions from services
    var appState = Provider.of<CheeseModel>(context);

        //setting how the marker in Google Map will appear.
    Marker initialCheeseMarker(LatLng point) => Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        icon: pinLocationIcon,
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CheeseInfoDialog(MarkerId(point.toString()),
                        appState.displayMessage(MarkerId(point.toString())));
              });
        });

    // final lat.Distance distance = new lat.Distance();

    // //get current user location
    // var userLocation = Provider.of<UserLocation>(context);

    // //get marker LatLng from marker ID using the cheese service
    // final LatLng position = appState.getLatLng(widget.marker);

    //Calculate distance between newly created marker and user location
    // void calculateDistance(latitude, longitude) {
    //   final double meter = distance(
    //       new lat.LatLng(userLocation.latitude, userLocation.longitude),
    //       new lat.LatLng(latitude, longitude));

    //   //if distance is less or equal to 50 meters, display notification
    //   if (meter <= 50) {
    //     notificationFunction(); //fires the function passed down the widget tree to display notification
    //   }
    // }

    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                        //navigate to previous context on click
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
                  //check to see if value is empty
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
                    appState.add(widget.markerMaker(widget.marker), _textEditingController.text);
                    //function call which adds the text to the cheese
                    // appState.sendMessage(widget.markerId, _textEditingController.text);
                    //closes dialog and returns to previous context, which is the home screen
                    Navigator.of(context)
                        .pop(); 
                  },
                  child: Text('Save Cheese!'),
                ),
              )
            ],
          ),
        ));
  }
}
