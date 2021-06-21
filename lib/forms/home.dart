import 'package:flutter/material.dart';
import 'package:personal_task_mobile/common/common.dart';
import 'package:personal_task_mobile/controllers/task_controller.dart';
import 'package:personal_task_mobile/forms/entry.dart';
import 'package:personal_task_mobile/models/task.dart';
import "package:intl/intl.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = [];

  // 初期処理
  @override
  void initState() {
    super.initState();

    Future(() async {
      tasks = await TaskController.readTasks();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // サイズ関連
    final _size = MediaQuery.of(context).size;

    // タスクの横幅（画面横幅 - アイコン横幅 - アイコン横幅）
    final double _widthTask = _size.width - Common.widthIcon - Common.widthIcon;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (Task task in tasks)
                Row(
                  children: [
                    Container(
                      width: _widthTask,
                      child: CheckboxListTile(
                        activeColor: Colors.grey,
                        title: Text(task.title,
                            style: TextStyle(
                                decoration: task.isCheck
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color:
                                    task.isCheck ? Colors.grey : Colors.black)),
                        subtitle: Text(
                          "due:" +
                              DateFormat(Common.formatDateOnly)
                                  .format(task.targetDate),
                          style: TextStyle(
                              decoration: task.isCheck
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color:
                                  task.isCheck ? Colors.grey : Colors.black45),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: task.isCheck,
                        onChanged: (bool? value) {
                          setState(() {
                            task.isCheck = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: Common.widthIcon,
                      child: IconButton(
                        icon: Icon(
                          Icons.bookmark,
                          color: task.isCheck
                              ? Colors.grey
                              : task.isDoing
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            task.isDoing = !task.isDoing;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: Common.widthIcon,
                      child: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          setState(() {
                            print("ボタンが押されました");
                          });
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // "push"で新規画面に遷移
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return Entry();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
