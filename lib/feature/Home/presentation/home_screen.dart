import 'package:cleanarch/feature/auth/presentation/screens/login_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        elevation: 10,
        backgroundColor: Colors.blue,
        title: const Text(
          "firebase test",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),

      body: Center(
        child: user == null
            ? const Text("No user logged in")
            : user.emailVerified
            ? const Text("Welcome 🎉", style: TextStyle(fontSize: 22))
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Please verify your email",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await user.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Verification email sent"),
                        ),
                      );
                    },
                    child: const Text("Send verification email"),
                  ),
                ],
              ),
      ),
    );
  }
}
