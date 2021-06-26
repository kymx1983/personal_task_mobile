import 'package:http/http.dart' as http;
import 'package:personal_task_mobile/common/common.dart';
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

    // 失敗した場合はからのリストを返す
    return [];
  }

  static Future<Task> showTasks(int taskId) async {
    var url = Uri.http(
      Common.domain,
      '/tasks/show/' + taskId.toString(),
    );

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return Task.setData(json.decode(response.body)['data']);
    }

    return Task.init();
  }

  static Future<int> createTask(Task task) async {
    var url = Uri.http(
      Common.domain,
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

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['data']['id'];
    }

    return 0;


  }

  static Future<int> updateTask(Task task) async {
    var url = Uri.http(
      Common.domain,
      '/tasks/update',
    );

    var response = await http.post(
      url,
      body: {
        "id": task.id.toString(),
        "user_id": task.userId.toString(),
        "title": task.title,
        "target_date": "2021-06-19 06:58:32",
        "memo": task.memo,
        "status": task.status.toString(),
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['data']['id'];
    }

    return 0;
  }

  static Future<bool> delete(int taskId) async {
    var url = Uri.http(
      Common.domain,
      '/tasks/delete',
    );

    var response = await http.post(
      url,
      body: {
        "id": taskId.toString(),
      },
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  static Future<bool> done(int taskId) async {
    var url = Uri.http(
      Common.domain,
      '/tasks/done',
    );

    var response = await http.post(
      url,
      body: {
        "id": taskId.toString(),
      },
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  static Future<bool> notDone(int taskId) async {
    var url = Uri.http(
      Common.domain,
      '/tasks/notdone',
    );

    var response = await http.post(
      url,
      body: {
        "id": taskId.toString(),
      },
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
