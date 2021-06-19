import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:personal_task_mobile/models/task.dart';

class TaskController {
  static Future<List<Task>> readTasks() async {
    var url = Uri.http(
      'localhost:3000',
      '/tasks/index',
    );

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Task.setList(jsonResponse);
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }

    return [];
  }
}
