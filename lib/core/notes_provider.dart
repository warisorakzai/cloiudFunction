import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfunction/Model/Notes_model.dart';
import 'package:cloudfunction/core/services/send_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  User? get user => _auth.currentUser;

  Future<void> addNotes(String title, String description) async {
    try {
      final uid = user?.uid;
      if (uid == null) return;

      final userDoc = await _firestore.collection('users').doc(uid).get();
      String? userToken = userDoc.data()?['token'];

      final docRef = await _firestore.collection('notes').add({
        'userId': uid,
        'title': title,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await SendNotificationService.sendNotificationUsingApi(
        token: userToken,
        title: 'New Note Added',
        body: 'Your note "$title" has been added successfully.',
        data: {"type": "note_add", "noteId": docRef.id},
      );

      final note = Note(id: docRef.id, title: title, description: description);

      _notes.add(note);
      notifyListeners();
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<void> fetchNotes() async {
    try {
      final uid = user?.uid;
      if (uid == null) return;

      final querySnapshot = await _firestore
          .collection('notes')
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .get();

      _notes = querySnapshot.docs
          .map(
            (doc) => Note(
              id: doc.id,
              title: doc['title'],
              description: doc['description'],
            ),
          )
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }

  Future<void> deleteNotes(String noteId) async {
    try {
      final uid = user?.uid;
      if (uid == null) return;

      final userDoc = await _firestore.collection('users').doc(uid).get();
      String? userToken = userDoc.data()?['token'];
      await _firestore.collection('notes').doc(noteId).delete();
      _notes.removeWhere((note) => note.id == noteId);

      await SendNotificationService.sendNotificationUsingApi(
        token: userToken,
        title: 'Note Deleted',
        body: 'One of your notes was deleted successfully.',
        data: {"type": "note_delete", "noteId": noteId},
      );
      notifyListeners();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  Future<void> updateNotes(
    String noteId,
    String title,
    String description,
  ) async {
    try {
      final uid = user?.uid;
      if (uid == null) return;

      final userDoc = await _firestore.collection('users').doc(uid).get();
      String? userToken = userDoc.data()?['token'];

      await SendNotificationService.sendNotificationUsingApi(
        token: userToken,
        title: 'Note Deleted',
        body: 'One of your notes was Updated successfully.',
        data: {"type": "note_delete", "noteId": noteId},
      );
      await _firestore.collection('notes').doc(noteId).update({
        'title': title,
        'description': description,
      });

      final index = _notes.indexWhere((note) => note.id == noteId);
      if (index != -1) {
        _notes[index] = Note(
          id: noteId,
          title: title,
          description: description,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error updating note: $e');
    }
  }
}
