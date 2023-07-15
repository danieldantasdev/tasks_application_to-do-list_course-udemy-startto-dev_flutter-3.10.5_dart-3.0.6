import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/models.dart';

class TaskService {
  Future<File> create(List<Task> tasks) async {
    String data = json.encode(tasks.map((task) => task.toJson()).toList());
    final file = await get();
    return file.writeAsString(data);
  }

  Future<File> get() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<String> readData() async {
    try {
      final file = await get();
      return file.readAsString();
    } catch (e) {
      print(e);
      return 'null';
    }
  }
}
