import 'package:flutter/material.dart';

class YourCheeseInfoDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          height: 300.0,
          width: 300.0,
          child: Padding(padding: EdgeInsets.all(17.0),
          child: Column(
              children:<Widget>[
                Image.asset('assets/icon/cheese_wheel.png', ),
                SizedBox(height: 15.0,),
                Text('This Cheese is Yours!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                SizedBox(height: 15.0,),
                Text('Are these pills supposed to wake me up or something? They\'re robots Morty! It\'s okay to shoot them!'),
                SizedBox(height: 15.0,),
              ]
          ),),
        ),
    );
  }
}