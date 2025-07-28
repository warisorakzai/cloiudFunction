import 'package:cloudfunction/core/CoustomWidgets.dart';
import 'package:cloudfunction/screens/auth/login_screen.dart';
import 'package:cloudfunction/screens/auth/signnup_provider.dart';
import 'package:cloudfunction/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final authprovider = Provider.of<SignnupProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 33, 33),

      appBar: AppBar(
        title: Text('Create Account', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Icon(Icons.person_add_alt, size: 80, color: Colors.white),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Text(
                'Join us !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Text(
                'Create an account to start nothing',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              CoustomTextField(text: 'Name', iconData: Icons.person),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              CoustomTextField(text: 'Email', iconData: Icons.email),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              passwordField(
                icons: Icons.password,
                text: 'Password',
                icon: Icons.remove_red_eye,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              passwordField(
                icons: Icons.password,
                text: 'Confirm Password',
                icon: Icons.remove_red_eye,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              GestureDetector(
                onTap: () async {
                  final message = await authprovider.SignupwithEmailandPassword(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                  );
                  if (message != null) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('Signup')),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have an Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text('Login', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
