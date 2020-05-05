import 'package:flutter/material.dart';

class CheeseInfoDialog extends StatelessWidget{
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
                Text('Cheese is Discovered!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                SizedBox(height: 15.0,),
                Text('Are these pills supposed to wake me up or something? They\'re robots Morty! It\'s okay to shoot them!'),
                SizedBox(height: 15.0,),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange[500],
                      onPressed: () {},
                      child: Text('PICK UP CHEESE')
                  ),
                )
              ]
          ),),
      ),
    );
  }
}