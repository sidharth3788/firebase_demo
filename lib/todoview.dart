import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_practice/controller.dart';

class MyTODOview extends StatefulWidget {
  const MyTODOview({super.key});

  @override
  _MyTODOviewState createState() => _MyTODOviewState();
}

class _MyTODOviewState extends State<MyTODOview> {
  final TodoController _todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _todoController.userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final todos = snapshot.data?.docs ?? [];
                  if (todos.isEmpty) {
                    return const Center(child: Text('No todos available'));
                  }

                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      final todoText = todo['data'] ?? 'No data';
                      return ListTile(
                        title: Text(todoText),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _todoController.titleTEC,
                    decoration: const InputDecoration(
                      hintText: 'Enter your todo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _todoController.addUser();
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
