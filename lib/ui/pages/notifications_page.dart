import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_notification.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchCaptures();
  }

  Future<void> fetchCaptures() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5002/api/get-captures'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        notifications = data.map((item) {
          final latitude = item['latitude']?.toString() ?? '';
          final longitude = item['longitude']?.toString() ?? '';
          return {
            'image_base64': item['image_base64'].toString(),
            'latitude': latitude.isNotEmpty ? latitude.trim() : '0.0',
            'longitude': longitude.isNotEmpty ? longitude.trim() : '0.0',
            'capture_time': item['capture_time'].toString(),
          };
        }).toList();
      });
    } else {
      print('Failed to fetch captures: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white, // Fond blanc pour la barre d'application
        iconTheme: IconThemeData(color: Colors.black), // Icônes en noir
      ),
      body: Container(
        color: Colors.white, // Fond de la page en blanc
        child: notifications.isEmpty
            ? Center(
          child: Text(
            'No notifications yet.',
            style: TextStyle(color: Colors.black),
          ),
        )
            : ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            final imageBase64 = notification['image_base64']!;
            final latitude = notification['latitude']!;
            final longitude = notification['longitude']!;
            final captureTime = notification['capture_time']!;

            return Card(
              color: Colors.white, // Fond blanc pour les cartes
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.memory(
                  base64Decode(imageBase64),
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, color: Colors.black); // Icône noire
                  },
                ),
                title: Text(
                  'Tentative détectée',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latitude: $latitude, Longitude: $longitude',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Time: $captureTime',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.info, color: Colors.black), // Icône noire
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationDetailPage(
                          imageBase64: imageBase64,
                          captureTime: captureTime,
                          latitude: double.parse(latitude),
                          longitude: double.parse(longitude),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
