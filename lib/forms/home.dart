import 'package:flutter/material.dart';
import 'package:personal_task_mobile/common/common.dart';
import 'package:personal_task_mobile/models/task.dart';
import "package:intl/intl.dart";

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Task> tasks = new List<Task>();

  // 初期処理
  @override
  void initState() {
    super.initState();

    Task task = Task.init();

    // テストデータ作成
    // 1件目
    task = Task.init();
    task.title = "1件目のタスク";
    tasks.add(task);

    // 2件目
    task = Task.init();
    task.title = "2件目のタスク";
    tasks.add(task);

    // 3件目
    task = Task.init();
    task.title = "3件目のタスク";
    tasks.add(task);

    // 4件目
    task = Task.init();
    task.title = "4件目のタスク";
    tasks.add(task);

    // 5件目
    task = Task.init();
    task.title = "5件目のタスク";
    tasks.add(task);

    // 6件目
    task = Task.init();
    task.title = "6件目のタスク";
    tasks.add(task);

    // 7件目
    task = Task.init();
    task.title = "7件目のタスク";
    tasks.add(task);

    // 8件目
    task = Task.init();
    task.title = "8件目のタスク";
    tasks.add(task);

    // 9件目
    task = Task.init();
    task.title = "9件目のタスク";
    tasks.add(task);

    // 10件目
    task = Task.init();
    task.title = "10件目のタスク";
    tasks.add(task);

    // 11件目
    task = Task.init();
    task.title = "11件目のタスク";
    tasks.add(task);

  }


  @override
  Widget build(BuildContext context) {

    // サイズ関連
    final _size = MediaQuery.of(context).size;

    // タスクの横幅（画面横幅 - アイコン横幅 - アイコン横幅）
    final double _widthTask = _size.width - Common.widthIcon - Common.widthIcon;

    return Scaffold(
        body: Container(
          child : SingleChildScrollView(
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
                                  color: task.isCheck ? Colors.grey : Colors.black)),
                          subtitle: Text(
                            "due:" + DateFormat(Common.formatDateOnly).format(task.due),
                            style: TextStyle(
                                decoration: task.isCheck
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: task.isCheck ? Colors.grey : Colors.black45),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: task.isCheck,
                          onChanged: (bool value) {
                            setState(() {
                              task.isCheck = value;
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
    );
  }
}
