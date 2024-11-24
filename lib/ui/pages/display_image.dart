import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisplayImageScreen extends StatefulWidget {
  final String userId;

  DisplayImageScreen({required this.userId});

  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  String? _imageBase64;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchImageFromSupabase();
  }

  Future<void> _fetchImageFromSupabase() async {
    final url = Uri.parse('http://192.168.1.40:5000/api/get-image');  // Update to your Flask server URL

    try {
      final response = await http
          .post(
        url,
        body: jsonEncode({"user_id": widget.userId}),
        headers: {"Content-Type": "application/json"},
      )
          .timeout(Duration(seconds: 30));  // Set the timeout to 30 seconds

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _imageBase64 = data['image_base64'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load image. Status Code: ${response.statusCode}';
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Request timed out. Please try again later.';
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching image: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Image'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _errorMessage != null
            ? Text(_errorMessage!)
            : _imageBase64 == null
            ? const Text('No image found for this user.')
            : Image.memory(base64Decode(_imageBase64!)),
      ),
    );
  }
}
