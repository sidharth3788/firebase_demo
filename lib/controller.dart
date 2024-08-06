import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoController {
  TextEditingController titleTEC = TextEditingController();
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('todos').snapshots();

  void addUser() {
    todos.add({'data': titleTEC.text});
    titleTEC.clear();
  }
}

// delete 

// update