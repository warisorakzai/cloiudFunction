import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfunction/Model/Notes_model.dart';
import 'package:flutter/material.dart';

class NotesProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Note> _notes = [];
  List<Note> get notes => _notes;
}
