import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl; // URL of the image to display
  final String imageName; // Name of the image for downloading

  FullScreenImagePage({required this.imageUrl, required this.imageName});

  // Function to download the image
  Future<void> downloadImage() async {
    try {
      // Fetch the image from the URL
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Save the image to the gallery
        final Uint8List imageData = response.bodyBytes;
        await ImageGallerySaver.saveImage(imageData, name: imageName);
        print("Image downloaded");
      } else {
        print("Failed to download image");
      }
    } catch (e) {
      print("Error downloading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full-Screen Image'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // White back icon
      ),
      body: Stack(
        children: [
          Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: downloadImage,
              child: Icon(Icons.download),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black, // Black background to make the image stand out
    );
  }
}
