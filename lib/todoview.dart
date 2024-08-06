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
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
              color: Color.fromARGB(255, 13, 38, 107),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
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
                          title: Text(
                            todoText,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 13, 38, 107),
                            ),
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
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 13, 38, 107)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 13, 38, 107)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 13, 38, 107)),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 13, 38, 107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () {
                          final text = _todoController.titleTEC.text.trim();
                          if (text.isNotEmpty) {
                            setState(() {
                              _todoController.addUser(text);
                              _todoController.titleTEC.clear();
                            });
                          }
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
