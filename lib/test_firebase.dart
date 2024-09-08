import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestFirebase extends StatefulWidget {
  const TestFirebase({super.key});

  @override
  State<TestFirebase> createState() => _TestFirebaseState();
}

class _TestFirebaseState extends State<TestFirebase> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final admin = <String, dynamic>{
              "id_admin": "001",
              "nama_admin": "Sahransyah",
              "username": "sahran",
              "password": "password123"
            };

            await _db.collection("admin").add(admin);
            print('Document added successfully');
          } catch (e) {
            print('Error adding document: $e');
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}