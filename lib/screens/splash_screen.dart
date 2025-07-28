import 'package:cloudfunction/screens/auth/login_screen.dart';
import 'package:cloudfunction/screens/auth/signnup_provider.dart';
import 'package:cloudfunction/screens/auth/signup_screen.dart';
import 'package:cloudfunction/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreen() async {
    await Future.delayed(Duration(seconds: 3));
    final authprovider = Provider.of<SignnupProvider>(context, listen: false);
    if (authprovider.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 33, 33),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenHeight / 5,

            width: screenWidth / 3,
            decoration: BoxDecoration(
              border: BoxBorder.all(color: Colors.blue, width: 2),
              shape: BoxShape.circle,
              color: Colors.blueAccent.withOpacity(0.6),
            ),
            child: Icon(Icons.edit, size: 40, color: Colors.blue),
          ),
          SizedBox(height: screenHeight / 25),
          Center(
            child: Text(
              'YOUR NOTES',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),

          Text(
            'Save your toughts Securely',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
