import 'package:cloudfunction/Model/Notes_model.dart';
import 'package:cloudfunction/core/services/Get_server_key.dart';
import 'package:cloudfunction/core/Notification_service%20.dart';
import 'package:cloudfunction/core/notes_provider.dart';
import 'package:cloudfunction/screens/auth/login_provider.dart';
import 'package:cloudfunction/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context, listen: false);
    final notificationProvider = Provider.of<NotificationService>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowAddBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),

      bottomSheet: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notificationProvider.requestNotification();
            notificationProvider.getDeviceToken(context);
            notificationProvider.firebaseInit(context);
            notificationProvider.setUpInteractMessage(context);
          });
          return SizedBox.shrink();
        },
      ),
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
      body: FutureBuilder(
        future: noteProvider.fetchNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            // Replace with your widget to display notes
            return Consumer<NotesProvider>(
              builder: (context, notesProvider, _) {
                final notes = notesProvider.notes;
                if (notes.isEmpty) {
                  return Center(
                    child: Text(
                      'No notes found.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      title: Text(
                        note.title,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        note.description,
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              ShowAddBottomSheet(context, note: note);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                             final noteId = note.id;
                               context.read<NotesProvider>().deleteNotes(noteId,);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

void ShowAddBottomSheet(BuildContext context, {Note? note}) {
  final noteProvider = Provider.of<NotesProvider>(context, listen: false);
  final titlecontroller = TextEditingController(text: note?.title ?? '');
  final descriptioncontroller = TextEditingController(
    text: note?.description ?? '',
  );
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color.fromARGB(255, 28, 28, 28),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8, // 80% height of screen
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, ScrollController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Add Notes',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: titlecontroller,
                    decoration: InputDecoration(
                      hintText: 'Notes Title',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF2C2C2C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: descriptioncontroller,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Notes Description',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF2C2C2C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (titlecontroller.text.isNotEmpty &&
                              descriptioncontroller.text.isNotEmpty) {
                            if (note == null) {
                              await noteProvider.addNotes(
                                titlecontroller.text,
                                descriptioncontroller.text,
                                
                              );
                            } else {
                              await noteProvider.updateNotes(
                                note.id,
                                titlecontroller.text,
                                descriptioncontroller.text,
                              );
                            }
                          }
                          GetServerKey getServerKey = GetServerKey();
                          String aceesToken = await getServerKey
                              .getServerKeytoken();
                          print(aceesToken);

                          Navigator.of(context).pop();
                          // if (titleController.text.isNotEmpty &&
                          //     descController.text.isNotEmpty) {
                          //   Navigator.of(context).pop();
                          //   final note = Note(
                          //     id: noteToEdit?.id ?? '',
                          //     title: titleController.text.trim(),
                          //     description: descController.text.trim(),
                          //   );
                          //   onAddOrUpdateNote(note, noteToEdit != null);
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Add Notes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
