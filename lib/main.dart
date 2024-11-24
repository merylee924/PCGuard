import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_project/ui/pages/counter_page.dart';
import 'package:test_project/ui/pages/display_image.dart';
import 'package:test_project/ui/pages/home_page.dart';
import 'package:test_project/ui/pages/image_capture_page.dart';
import 'package:test_project/ui/pages/login_page.dart';
import 'package:test_project/ui/pages/map_page.dart';
import 'package:test_project/ui/pages/settings_page.dart';
import 'package:test_project/ui/pages/signup_page.dart';
import 'package:test_project/ui/pages/welcome_page.dart';
import 'package:test_project/ui/pages/profile_user.dart';

import 'firebase_options.dart';
import 'package:test_project/ui/pages/theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bdvyssupdffdzyczckgb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJkdnlzc3VwZGZmZHp5Y3pja2diIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjYxNjQwMTIsImV4cCI6MjA0MTc0MDAxMn0.GSPzzjHMNoAKyOZaw0Z2HtPezPmJ7rWSV6-lHKsnsQs',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/display') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return DisplayImageScreen(userId: args);
            },
          );
        }
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case "/login":
                return LoginPage();
              case "/welcome_page":
                return WelcomePage();
              case "/counter":
                return CounterPage();
              case "/homepage":
                return HomePage();
              case "/signup":
                return SignUpPage();
              case "/imagecapture":
                return ImageCapturePage();
              case "/settingspage":
                return SurveillanceConfigPage();
              case "/settingspage":
                return SurveillanceConfigPage();
              case "/UserProfile":
                return UserProfileUI();
              case "/map":
                final args = settings.arguments as Map<String, double>;  // On attend latitude et longitude
                return MapPage(latitude: args['latitude']!, longitude: args['longitude']!);
              default:
                return WelcomePage();
            }
          },
        );
      },
      initialRoute: "/welcome_page",
      theme: CustomTheme.lightTheme(),
      darkTheme: CustomTheme.darkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
