import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoController {
  TextEditingController titleTEC = TextEditingController();
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('todos').snapshots();

  void addUser(String text) {
    FirebaseFirestore.instance.collection('todos').add({
      'data': text,
    });
    titleTEC.clear();
  }

  void deleteUser(String id) {
    todos.doc(id).delete().then((_) {
      print('Todo deleted');
    }).catchError((error) {
      print('Failed to delete todo: $error');
    });
  }
}
