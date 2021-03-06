import 'package:flutter/material.dart';
import 'package:personal_task_mobile/common/common.dart';
import 'package:personal_task_mobile/controllers/task_controller.dart';
import 'package:personal_task_mobile/enums/entry_mode.dart';
import 'package:personal_task_mobile/forms/entry.dart';
import 'package:personal_task_mobile/models/task.dart';
import "package:intl/intl.dart";

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

    // タスクの横幅（画面横幅 - アイコン横幅 - アイコン横幅 - 20）
    final double _widthTask = _size.width - Common.widthIcon - 20;

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
                          width: _widthTask,
                          child: CheckboxListTile(
                            activeColor: Colors.grey,
                            title: Text(tasks[index].title,
                                style: TextStyle(
                                    decoration: tasks[index].isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: tasks[index].isDone
                                        ? Colors.grey
                                        : Colors.black)),
                            subtitle: Text(
                              "due:" +
                                  DateFormat(Common.formatDateOnly)
                                      .format(tasks[index].targetDate),
                              style: TextStyle(
                                  decoration: tasks[index].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: tasks[index].isDone
                                      ? Colors.grey
                                      : Colors.black45),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: tasks[index].isDone,
                            onChanged: (bool? value) async{
                              setState(() {
                                tasks[index].isDone = value!;
                              });

                              print(value);
                              if(value!) {
                                await TaskController.done(tasks[index].id);
                              } else {
                                await TaskController.notDone(tasks[index].id);
                              }

                            },
                          ),
                        ),
                        Container(
                          width: Common.widthIcon,
                          child: IconButton(
                            icon: Icon(
                              Icons.info_outline,
                            ),
                            onPressed: () async {
                              // "push"で新規画面に遷移
                              Task task = await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  // 遷移先の画面としてリスト追加画面を指定
                                  return Entry(
                                    mode: EntryMode.update,
                                    taskId: tasks[index].id,
                                  );
                                }),
                              );

                              print(task.title);

                              if(task.isDelete) {
                                setState(() {
                                  tasks.removeAt(index);
                                });
                              } else if(task.id != 0){
                                setState(() {
                                  tasks[index] = task;
                                });
                              }
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
        onPressed: () async {
          // "push"で新規画面に遷移
          Task task = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return Entry(
                mode: EntryMode.create,
                taskId: 0,
              );
            }),
          );

          if (task.title != "") {
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
