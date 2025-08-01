import 'package:flutter/material.dart';

class CoustomTextField extends StatelessWidget {
  final String text;
  final IconData iconData;
  final TextEditingController controller;
  const CoustomTextField({
    super.key,
    required this.text,
    required this.iconData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hint: Text(text, style: TextStyle(color: Colors.white)),
        prefixIcon: Icon(iconData, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 116, 118, 120),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
      ),
    );
  }
}

class passwordField extends StatelessWidget {
  // final TextEditingController controller;
  final IconData icon;
  final IconData icons;
  final String text;
  final TextEditingController controller;
  const passwordField({
    super.key,
    required this.icon,
    required this.text,
    required this.icons,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icons, color: Colors.white),

        suffixIcon: Icon(icon, color: Colors.white),
        hintText: text,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color.fromARGB(255, 116, 118, 120),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
        ),
      ),
    );
  }
}
