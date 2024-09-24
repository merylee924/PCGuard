import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Captured Images"),
        backgroundColor: Color(0xFFC49D83),
      ),
      body: Center(
        child: Text(
          "No images captured yet.",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
