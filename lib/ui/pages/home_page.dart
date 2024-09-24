import 'package:flutter/material.dart';
import 'package:test_project/ui/pages/image_capture_page.dart';
import 'package:test_project/ui/pages/notifications_page.dart';
import 'package:test_project/ui/pages/settings_page.dart';
import 'package:test_project/ui/pages/theme.dart';
import 'package:test_project/ui/pages/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? CustomTheme.darkTheme() : CustomTheme.lightTheme(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Set to transparent if needed
          elevation: 0.0, // Remove shadow
          actions: [
            // Circle avatar (profile image)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'), // Profile image path
                radius: 20,
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDashboard(context), // Dashboard part of the page
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF882B56), // New color for the navigation bar
          selectedItemColor: const Color(0xFFC8C6C2),
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Captured Images',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageCapturePage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveillanceConfigPage()),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
            });
          },
          backgroundColor: const Color(0xFF7C4A61),
          child: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
        ),
      ),
    );
  }

  // Widget for the dashboard
  Widget _buildDashboard(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SizedBox(height: 10), // Just for spacing
              // Add other widgets if necessary
            ],
          ),
        ),
      ),
    );
  }
}

