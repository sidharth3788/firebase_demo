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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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

                    return ListView.separated(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        final todoText = todo['data'] ?? 'No data';
                        return ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(todoText),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _todoController.deleteUser(todo.id);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
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
                        hintText: 'Enter your Text here...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.blue,
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
      ),
    );
  }
}
