import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:ListView(
            children:[
              DrawerHeader(
                  decoration:BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.white,
                        Colors.deepOrange
                      ])
                  ),
                  child:Center(
                    child: CircleAvatar(
                      backgroundImage:AssetImage("images/logo.jpg") ,
                      radius:40,
                    ),
                  )
              ),
              ListTile(
                title: Text("Counter",style:TextStyle(fontSize: 22),),
                leading: Icon(Icons.home,color:Colors.orange),
                trailing: Icon(Icons.arrow_right,color:Colors.orange,),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context,"/counter");

                },
              ),
              Divider(height: 4,color:Colors.deepOrange,),
              ListTile(
                title: Text("Meteo",style:TextStyle(fontSize: 22),),
                leading: Icon(Icons.home,color:Colors.orange),
                trailing: Icon(Icons.arrow_right,color:Colors.orange,),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context,"/meteo");

                },
              ),
              Divider(height: 4,color:Colors.deepOrange,),
              ListTile(
                title: Text("Gallery",style:TextStyle(fontSize: 22),),
                leading: Icon(Icons.home,color:Colors.orange),
                trailing: Icon(Icons.arrow_right,color:Colors.orange,),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context,"galleryPage");

                },
              ),
              Divider(height: 4,color:Colors.deepOrange,),
            ]
        )
    );
  }
}
