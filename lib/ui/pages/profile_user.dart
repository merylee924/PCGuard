import 'package:flutter/material.dart';
import 'update_profile.dart';

class UserProfileUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'meriem oulja',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'meriemoulja2@gmail.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Edit Profile', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Divider(),
            _buildSectionTitle('Settings'),
            _buildListTile(
              title: 'Number of Failed Login Attempts Allowed',
              icon: Icons.lock,
              trailing: Text('3', style: TextStyle(color: Colors.black)),
            ),
            _buildListTile(
              title: 'Last PC Access',
              icon: Icons.access_time,
              trailing: Text('24 Nov 2024, 12:45 PM', style: TextStyle(color: Colors.black)),
            ),
            _buildListTile(
              title: 'Location Tracking',
              icon: Icons.location_on,
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.black,
              ),
            ),
            Divider(),
            _buildSectionTitle('Preferences'),
            _buildSwitchTile(
              title: 'Push Notifications',
              icon: Icons.notifications,
              value: true,
              onChanged: (value) {},
            ),
            _buildSwitchTile(
              title: 'Email Alerts',
              icon: Icons.email,
              value: false,
              onChanged: (value) {},
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  // Logout action
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required Widget trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: trailing,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      activeColor: Colors.black,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Text(title, style: TextStyle(fontSize: 16)),
      secondary: Icon(icon, color: Colors.black),
      value: value,
      onChanged: onChanged,
    );
  }
}
