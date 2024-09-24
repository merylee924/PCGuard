import 'package:flutter/material.dart';

class MeteoPage extends StatelessWidget {
  const MeteoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Meteo Page'),),
      body:Center(
        child:Text('Meteo Page',style:Theme.of(context).textTheme.headlineMedium)
      ),
    );
  }
}
