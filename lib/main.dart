import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_project/ui/pages/counter_page.dart';
import 'package:test_project/ui/pages/gallery_page.dart';
import 'package:test_project/ui/pages/home_page.dart';
import 'package:test_project/ui/pages/image_capture_page.dart';
import 'package:test_project/ui/pages/login_page.dart';
import 'package:test_project/ui/pages/meteo_page.dart';
import 'package:test_project/ui/pages/settings_page.dart';
import 'package:test_project/ui/pages/signup_page.dart';
import 'package:test_project/ui/pages/welcome_page.dart';
import 'firebase_options.dart';
import 'package:test_project/ui/pages/theme.dart';

// Instance globale du plugin de notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Supabase
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
      routes: {
        "/login": (context) => LoginPage(),
        "/welcome_page": (context) => WelcomePage(),
        "/meteo": (context) => MeteoPage(),
        "/gallery": (context) => GalleryPage(),
        "/counter": (context) => CounterPage(),
        "/homepage": (context) => HomePage(),
        "/signup": (context) => SignUpPage(),
        "/imagecapture": (context) => ImageCapturePage(),
        "/settingspage": (context) => SurveillanceConfigPage(),  // Corriger le nom de la page
      },
      initialRoute: "/homepage",  // La première page affichée

      // Apply the custom themes and system theme mode
      theme: CustomTheme.lightTheme(),
      darkTheme: CustomTheme.darkTheme(),
      themeMode: ThemeMode.system, // Switches between light and dark based on system preferences

      home: WelcomePage(),  // Mettre WelcomePage ici pour être en accord avec initialRoute
    );
  }
}
