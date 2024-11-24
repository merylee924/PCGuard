import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Pour les requêtes HTTP
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart'; // Pour formater la date et l'heure

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
    fetchLatestImage(); // Appel de la fonction pour récupérer l'image la plus récente
  }

  void connectToSocket() {
    socket = IO.io('http://192.168.1.131:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.on('image_captured', (data) {
      // Comparez le temps de capture pour déterminer si c'est la plus récente
      String newCaptureTime = data['time'];
      if (captureTime == null ||
          DateTime.parse(newCaptureTime).isAfter(DateTime.parse(captureTime!))) {
        setState(() {
          base64Image = data['image'];
          captureTime = newCaptureTime;
        });
      }
    });

    socket?.onConnect((_) {
      print('Connecté au serveur Socket.IO');
    });

    socket?.onDisconnect((_) {
      print('Déconnecté du serveur Socket.IO');
    });
  }

  Future<void> fetchLatestImage() async {
    final url = Uri.parse('http://127.0.0.1:5004/api/get-latest-capture'); // Modifiez l'URL ici
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final latestCapture = jsonDecode(response.body);
        setState(() {
          base64Image = latestCapture['image_base64'];
          captureTime = latestCapture['capture_time'];
        });
      } else {
        print('Échec de la récupération des images');
      }
    } catch (e) {
      print('Erreur lors de la récupération des images: $e');
    }
  }

  void lockPC() async {
    final url = Uri.parse('http://localhost:5003/lock_pc'); // Modifiez l'URL ici si nécessaire
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': '12345', // Remplacez par l'ID de l'utilisateur approprié
        }),
      );

      if (response.statusCode == 200) {
        print('PC verrouillé avec succès');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Le PC a été verrouillé avec succès.')),
        );
      } else {
        print('Échec du verrouillage du PC');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible de verrouiller le PC.')),
        );
      }
    } catch (e) {
      print('Erreur: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la tentative de verrouillage.')),
      );
    }
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
        title: const Text('Surveillance PC'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (base64Image != null)
                Column(
                  children: [
                    Text(
                      "⚠️ Une tentative d'accès non autorisé a été détectée !",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          captureTime != null
                              ? DateFormat('dd MMM yyyy, hh:mm a')
                              .format(DateTime.parse(captureTime!))
                              : 'Date non disponible',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Image.memory(
                      base64Decode(base64Image!),
                      width: 300,
                      height: 300,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Voici l'image de la dernière tentative.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              else
                const Text(
                  'Aucune tentative détectée pour le moment.',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: lockPC,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Verrouiller le PC',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Appuyez sur ce bouton pour verrouiller le PC à distance.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
