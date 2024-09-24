import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SurveillanceConfigPage extends StatefulWidget {
  @override
  _SurveillanceConfigPageState createState() => _SurveillanceConfigPageState();
}

class _SurveillanceConfigPageState extends State<SurveillanceConfigPage> {
  bool isSurveillanceEnabled = false;
  String surveillanceStatus = "Surveillance is disabled";
  bool isLocationEnabled = true;
  bool isEmailNotificationEnabled = true;
  bool enableVideoCapture = false;
  bool silentMode = false;
  int maxLoginAttempts = 2;
  int videoDuration = 10; // Duration of video capture in seconds
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  void toggleSurveillance() {
    setState(() {
      isSurveillanceEnabled = !isSurveillanceEnabled;
      surveillanceStatus = isSurveillanceEnabled
          ? "Surveillance is enabled"
          : "Surveillance is disabled";
    });
  }

  void saveConfiguration() async {
    if (isEmailNotificationEnabled && !_formKey.currentState!.validate()) {
      return;
    }

    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You need to be logged in to save preferences!"),
        ),
      );
      return;
    }

    try {
      await Supabase.instance.client.from('preferences').upsert([
        {
          'user_id': user.id,
          'preference_key': 'surveillance_enabled',
          'preference_value': isSurveillanceEnabled.toString(),
        },
        {
          'user_id': user.id,
          'preference_key': 'max_login_attempts',
          'preference_value': maxLoginAttempts.toString(),
        },
        {
          'user_id': user.id,
          'preference_key': 'location_enabled',
          'preference_value': isLocationEnabled.toString(),
        },
        {
          'user_id': user.id,
          'preference_key': 'email_notifications_enabled',
          'preference_value': isEmailNotificationEnabled.toString(),
        },
        {
          'user_id': user.id,
          'preference_key': 'email',
          'preference_value': _emailController.text,
        },
        {
          'user_id': user.id,
          'preference_key': 'video_capture_enabled',
          'preference_value': enableVideoCapture.toString(),
        },
        {
          'user_id': user.id,
          'preference_key': 'video_duration',
          'preference_value': videoDuration.toString(), // Save video duration
        },
        {
          'user_id': user.id,
          'preference_key': 'silent_mode',
          'preference_value': silentMode.toString(),
        },
      ]).execute();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Configuration saved successfully!"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
        ),
      );
    }
  }

  void loadPreferences() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return;
    }

    await Supabase.instance.client
        .from('preferences')
        .select()
        .eq('user_id', user.id)
        .execute();
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required String description,
    required Widget control,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Theme.of(context).primaryColor),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(description),
            SizedBox(height: 10),
            control,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get current theme

    return Scaffold(
      appBar: AppBar(
        title: Text("Surveillance Configuration"),
        backgroundColor: theme.primaryColor, // Use theme's primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildCard(
                icon: Icons.security,
                title: "Enable Surveillance",
                description:
                "When enabled, any suspicious login attempts will trigger the system.",
                control: SwitchListTile(
                  value: isSurveillanceEnabled,
                  onChanged: (value) => toggleSurveillance(),
                  title: Text(
                      "Surveillance is ${isSurveillanceEnabled ? 'enabled' : 'disabled'}"),
                ),
              ),
              buildCard(
                icon: Icons.lock,
                title: "Max Login Attempts",
                description:
                "Set the maximum number of incorrect login attempts before triggering an alert.",
                control: Slider(
                  value: maxLoginAttempts.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: "$maxLoginAttempts",
                  onChanged: (value) {
                    setState(() {
                      maxLoginAttempts = value.toInt();
                    });
                  },
                ),
              ),
              buildCard(
                icon: Icons.location_on,
                title: "Location Tracking",
                description:
                "Enable or disable tracking of the device's location during suspicious attempts.",
                control: SwitchListTile(
                  value: isLocationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isLocationEnabled = value;
                    });
                  },
                ),
              ),
              buildCard(
                icon: Icons.videocam,
                title: "Video Capture Duration",
                description:
                "Set the duration (in seconds) for video capture during suspicious attempts.",
                control: Slider(
                  value: videoDuration.toDouble(),
                  min: 5,
                  max: 60,
                  divisions: 11,
                  label: "$videoDuration seconds",
                  onChanged: (value) {
                    setState(() {
                      videoDuration = value.toInt();
                    });
                  },
                ),
              ),
              buildCard(
                icon: Icons.email,
                title: "Email Notifications",
                description:
                "Receive an email notification when suspicious login attempts are detected.",
                control: Column(
                  children: [
                    SwitchListTile(
                      value: isEmailNotificationEnabled,
                      onChanged: (value) {
                        setState(() {
                          isEmailNotificationEnabled = value;
                        });
                      },
                    ),
                    if (isEmailNotificationEnabled)
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: saveConfiguration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                ),
                icon: Icon(Icons.save, color: theme.colorScheme.onPrimary),
                label: Text(
                  "Save Configuration",
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
