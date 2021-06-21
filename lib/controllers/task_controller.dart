import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:personal_task_mobile/models/task.dart';

class TaskController {
  static Future<List<Task>> readTasks() async {
    var url = Uri.http(
      'localhost:3000',
      '/tasks/index',
    );

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Task.setList(jsonResponse);
    }

    return [];
  }

  static Future<int> createTask(Task task) async {
    var url = Uri.http(
      'localhost:3000',
      '/tasks/create',
    );

    var response = await http.post(
      url,
      body: {
        "user_id": task.userId.toString(),
        "title": task.title,
        "target_date": "2021-06-19 06:58:32",
        "memo": task.memo,
        "status": task.status.toString(),
      },
    );

    var data = json.decode(response.body);
    return data['data']['id'];

    return 0;
  }
}
