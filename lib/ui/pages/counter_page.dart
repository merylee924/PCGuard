import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MyDrawer(),
      appBar: AppBar(title:Text("Counter"),),
      body:Center(
          child:Text('Counter Value=>${counter}',
    style:TextStyle(fontSize: 22,color:Colors.deepOrange),
      ),
      ),
      floatingActionButton:Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
          FloatingActionButton(
            child:Icon(Icons.add),
            onPressed: ()
            {
              setState((){ //il va execute le contenu et rappeller la methode build pour actualiser
                ++counter;
              });
              print(counter);
            },),
          SizedBox(width:8,),
          FloatingActionButton(
            child:Icon(Icons.remove),
            onPressed: ()
            {
              setState((){ //il va execute le contenu et rappeller la methode build pour actualiser
                --counter;
              });
              print(counter);
            },),
        ]
      )
    );
  }
}