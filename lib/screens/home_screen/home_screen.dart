import 'package:cloudfunction/screens/auth/login_provider.dart';
import 'package:cloudfunction/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 33, 33),

      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white)),
        actions: [
          //logout button
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              context
                  .read<LoginProvider>()
                  .logout()
                  .then((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  })
                  .catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout failed: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 33, 33),
      ),
      body: Center(
        child: Text(
          'Welcome to Home Screen',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
