import 'package:cleanarch/core/local/hive_service_impl.dart';
import 'package:cleanarch/core/services_locator/services_locator.dart';
import 'package:cleanarch/feature/Home/presentation/home_screen.dart';
import 'package:cleanarch/feature/auth/presentation/screens/login_screens.dart';
import 'package:cleanarch/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DI.init();
  await HiveServiceImpl.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase broject ',
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const LoginScreen(),
      
    );
  }
}
