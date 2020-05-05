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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _textEditingController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              RaisedButton(
                color: Colors.orange,
                textColor: Colors.white,
                onPressed: () {
                  print('this is the marker id: ${widget.markerId}');
                  appState.sendMessage(widget.markerId, _textEditingController.text);
                  print('the text is ${_textEditingController.text}');
                },
                child: Text('Save Cheese!'),
              )
            ],
          ),
        ));
  }
}
