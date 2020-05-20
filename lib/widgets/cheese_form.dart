import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/cheese_service.dart';

class CheeseForm extends StatefulWidget {
  final LatLng markerLatLang;
  final Function markerMaker;

  CheeseForm(this.markerLatLang, this.markerMaker);

  @override
  State<StatefulWidget> createState() {
    return CheeseFormState();
  }
}

class CheeseFormState extends State<CheeseForm> {
  final _formKey = GlobalKey<FormState>();

  //controller placed before build so as to not cause constant rebuilding and disappearing of text
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //call app state so as to get functions from services
    var appState = Provider.of<CheeseModel>(context);

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
                    //add new marker and cheese
                    appState.add(widget.markerMaker(widget.markerLatLang),
                        _textEditingController.text);

                    //closes dialog and returns to previous context, which is the home screen
                    Navigator.of(context).pop();
                  },
                  child: Text('Save Cheese!'),
                ),
              )
            ],
          ),
        ));
  }
}
