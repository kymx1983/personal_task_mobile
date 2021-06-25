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
    final double _widthTask = _size.width - Common.widthIcon;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: _size.width,
                height: _size.height,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: _widthTask - 20,
                          child: CheckboxListTile(
                            activeColor: Colors.grey,
                            title: Text(tasks[index].title,
                                style: TextStyle(
                                    decoration: tasks[index].isCheck
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color:
                                    tasks[index].isCheck ? Colors.grey : Colors.black)),
                            subtitle: Text(
                              "due:" +
                                  DateFormat(Common.formatDateOnly)
                                      .format(tasks[index].targetDate),
                              style: TextStyle(
                                  decoration: tasks[index].isCheck
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color:
                                  tasks[index].isCheck ? Colors.grey : Colors.black45),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: tasks[index].isCheck,
                            onChanged: (bool? value) {
                              setState(() {
                                tasks[index].isCheck = value!;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: Common.widthIcon,
                          child: IconButton(
                            icon: Icon(
                              Icons.info_outline,
                            ),
                            onPressed: () {
                              setState(() {
                                tasks[index].isDoing = !tasks[index].isDoing;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // "push"で新規画面に遷移
          Task task = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return Entry();
            }),
          );

          if(task.title != ""){
            setState(() {
              tasks.add(task);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
