import 'package:flutter/material.dart';
import 'package:instagram/Responsive/Responsive_Layout.dart';
import 'package:instagram/Responsive/mobile_Screen_Layout.dart';
import 'package:instagram/Responsive/web_Screen_Layout.dart';
import 'package:instagram/Screens/Login_Screen.dart';
import 'package:instagram/utilities/Colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: LoginScreen(),
      // home: const Responsive_Layout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   WebScreenLayout: WebScreenLayout(),
      // ),
    );
  }
}
