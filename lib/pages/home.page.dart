import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TaskService _taskService = TaskService();

  void _addTask() {
    setState(() {
      Task newTask = Task(
        title: _taskController.text,
        ok: false,
      );
      _taskController.clear();

      _tasks.add(newTask);

      _taskService.create(_tasks);
    });
  }

  @override
  void initState() {
    super.initState();

    _taskService.readData().then(
          (value) => setState(() {
            _tasks = (json.decode(value) as List<dynamic>)
                .map((taskJson) => Task.fromJson(taskJson))
                .toList();
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Icon(
          Icons.task,
          size: 50,
          color: Colors.blue,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                        labelText: 'Nova Tarefa',
                        labelStyle: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Icon(Icons.add),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Task task = _tasks[index];
                  return CheckboxListTile(
                    title: Text(task.title),
                    value: task.ok,
                    onChanged: (bool? value) {
                      setState(() {
                        task.ok = value!;
                        _taskService.create(_tasks);
                      });
                    },
                    secondary: CircleAvatar(
                      child: Icon(task.ok ? Icons.check : Icons.error),
                    ),
                  );
                },
                itemCount: _tasks.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
