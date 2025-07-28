import 'package:cloudfunction/core/CoustomWidgets.dart';
import 'package:cloudfunction/screens/auth/login_provider.dart';
import 'package:cloudfunction/screens/auth/signup_screen.dart';
import 'package:cloudfunction/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<LoginProvider>(context);
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 33, 33),

      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 80, color: Colors.white),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              'Welcome Back !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            Text(
              'Please Sign In Continue',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            CoustomTextField(text: 'Email', iconData: Icons.email),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            passwordField(
              icon: Icons.remove_red_eye,
              text: 'Password',
              icons: Icons.password,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            GestureDetector(
              onTap: () async {
                final messsage = await loginprovider.LoginwithEmailPAssword(
                  emailcontroller.text.trim(),
                  passwordController.text.trim(),
                );
                if (messsage != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(messsage)));
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                }
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('Login')),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont Have any Account',
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: Text('Sign up', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
