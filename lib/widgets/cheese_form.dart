import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/cheese_model.dart';

class CheeseForm extends StatefulWidget {
  final MarkerId markerId;

  CheeseForm(this.markerId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheeseFormState();
  }
}

class CheeseFormState extends State<CheeseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    var appState = Provider.of<CheeseModel>(context);
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
                  IconButton( //close button
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
              TextFormField( //text input field
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
              SizedBox(height: 7.0,),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: RaisedButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  onPressed: () {
                    appState.sendMessage( //function call which adds the text to the cheese
                        widget.markerId, _textEditingController.text);
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
