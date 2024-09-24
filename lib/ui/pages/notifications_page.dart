import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_project/ui/pages/FullScreenImage.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  IO.Socket? socket;
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  // Connect to Socket.IO
  void connectToSocket() {
    socket = IO.io('http://127.0.0.1:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    // Listen for 'image_captured' event
    socket!.on('image_captured', (data) {
      setState(() {
        notifications.add({
          'image_url': data['image_url'], // Image URL from backend
          'time': data['time'],
        });
      });
    });
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(notification['image_url']!), // Display image from URL
              title: Text('Tentative détectée à ${notification['time']}'),
              onTap: () {
                // Navigate to full-screen image page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImagePage(
                      imageUrl: notification['image_url']!,
                      imageName: 'tentative_${notification['time']}', // Name of the image
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
