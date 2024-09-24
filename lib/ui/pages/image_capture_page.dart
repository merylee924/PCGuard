import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ImageCapturePage extends StatefulWidget {
  @override
  _ImageCapturePageState createState() => _ImageCapturePageState();
}

class _ImageCapturePageState extends State<ImageCapturePage> {
  IO.Socket? socket;
  String? base64Image;
  String? captureTime;

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io('http://192.168.1.131:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.on('image_captured', (data) {
      setState(() {
        base64Image = data['image'];
        captureTime = data['time'];
      });
    });

    socket?.onConnect((_) {
      print('Connecté au serveur Socket.IO');
    });

    socket?.onDisconnect((_) {
      print('Déconnecté du serveur Socket.IO');
    });
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Capturée'),
      ),
      body: Center(
        child: base64Image != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Image capturée à: $captureTime'),
            const SizedBox(height: 20),
            Image.memory(
              base64Decode(base64Image!),
              width: 300,
              height: 300,
            ),
          ],
        )
            : const Text('Aucune image capturée pour le moment.'),
      ),
    );
  }
}
