import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';

class NotificationDetailPage extends StatelessWidget {
  final String imageBase64;
  final String captureTime;
  final double latitude;
  final double longitude;

  NotificationDetailPage({
    required this.imageBase64,
    required this.captureTime,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la notification'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Afficher l'image
            Center(
              child: Image.memory(
                base64Decode(imageBase64),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Afficher l'heure et la date
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 10),
                Text('Heure de capture: $captureTime'),
              ],
            ),
            SizedBox(height: 20),
            // Afficher la localisation
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 10),
                Text('Latitude: $latitude, Longitude: $longitude'),
              ],
            ),
            SizedBox(height: 20),
            // Afficher la carte avec la localisation

          ],
        ),
      ),
    );
  }
}
