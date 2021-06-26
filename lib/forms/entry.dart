import 'package:flutter/material.dart';
import 'package:personal_task_mobile/common/common.dart';
import "package:intl/intl.dart";
import 'package:personal_task_mobile/controllers/task_controller.dart';
import 'package:personal_task_mobile/enums/entry_mode.dart';
import 'package:personal_task_mobile/models/task.dart';

class Entry extends StatefulWidget {
  final EntryMode? mode;
  final int? taskId;

  Entry({key: Key, this.mode, this.taskId});

  @override
  _EntryState createState() => _EntryState();
}

enum SingingCharacter { day, week, month, target }

class _EntryState extends State<Entry> {
  // 日付の指定を行うかどうかのフラグ
  bool _isDate = false;

  // 選択した日付
  DateTime _date = new DateTime.now();

  // 選択した時刻（初期値は9:00とする）
  TimeOfDay _time = new TimeOfDay(hour: 9, minute: 0);

  // チェックリスト
  List<String> todoList = [];

  // コントローラ
  var _taskController = TextEditingController();
  var _checklistController = TextEditingController();
  var _memoController = TextEditingController();

  // パラメータを取得
  EntryMode? _mode;
  int? _taskId = 9;

  // タスク
  Task task = Task.init();

  // 初期処理
  @override
  void initState() {
    super.initState();

    // パラメータを取得
    _mode = widget.mode;
    _taskId = widget.taskId;

    print("初期処理開始");

    if (_mode == EntryMode.update) {
      print("編集処理開始");
      Future(() async {
        task = await TaskController.showTasks(_taskId!);
        setState(() {
          _taskController.text = task.title;
          _memoController.text = task.memo;
        });

        print(task.title);
      });

      print("編集処理終了");
    }

    print("初期処理終了");
  }

  @override
  Widget build(BuildContext context) {
    // サイズ関連
    final _size = MediaQuery.of(context).size;

    // 項目名の横幅
    final double _widthItemTitle = 80;

    // 項目の横幅（画面横幅 - 項目名の横幅 - マージン）
    final double _widthItem = _size.width - _widthItemTitle - 20;

    // 追加ボタンの横幅
    final double _widthAddButton = 90;

    final double _widthTrashIcon = 20;

    return Scaffold(
      appBar: AppBar(
        title: Text("タスク追加"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
          crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: _widthAddButton,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      Task task = Task.init();
                      task.userId = 1;
                      task.title = _taskController.text;
                      task.memo = _memoController.text;
                      task.status = 0;

                      if (_mode == EntryMode.create) {
                        task.id = await TaskController.createTask(task);
                      } else if (_mode == EntryMode.update) {
                        task.id = _taskId!;
                        await TaskController.updateTask(task);
                      }

                      Navigator.of(context).pop(task);
                    },
                    child: Text('登録'),
                  ),
                ),
                Container(
                  width: 130,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop(Task.init());
                    },
                    child: Text('キャンセル'),
                  ),
                ),
                (_mode == EntryMode.update)
                    ? Container(
                        width: 100,
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () async {
                            await TaskController.delete(_taskId!);
                            task.isDelete = true;
                            Navigator.of(context).pop(task);
                          },
                          child: Text('削除'),
                        ),
                      )
                    : Text(""),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("タスク"),
                ),
                Container(
                  width: _widthItem,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: true,
                    // 入力数
                    maxLength: 50,
                    obscureText: false,
                    maxLines: 1,
                    controller: _taskController,
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("日時"),
                ),
                Container(
                  width: _widthItem,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          new Switch(
                            value: _isDate,
                            activeColor: Colors.blue,
                            activeTrackColor: Colors.blue,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey,
                            onChanged: (bool e) {
                              setState(() {
                                _isDate = e;
                              });

                              print(_isDate);
                            },
                          ),
                          Text('日時を指定する'),
                        ],
                      ),
                      if (_isDate)
                        Row(
                          children: [
                            Container(
                              width: _widthItemTitle,
                              child: Text("日付"),
                            ),
                            Text(
                              DateFormat(Common.formatDateOnly).format(_date),
                            ),
                            Container(
                              width: Common.widthIcon,
                              child: IconButton(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectDate(context);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      if (_isDate)
                        Row(
                          children: [
                            Container(
                              width: _widthItemTitle,
                              child: Text("時刻"),
                            ),
                            Text(
                              _time.hour.toString().padLeft(2, "0") +
                                  ":" +
                                  _time.minute.toString().padLeft(2, "0"),
                            ),
                            Container(
                              width: Common.widthIcon,
                              child: IconButton(
                                icon: Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectTime(context);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("メモ"),
                ),
                Container(
                  width: _widthItem,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: true,
                    obscureText: false,
                    maxLines: 5,
                    controller: _memoController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      // onChanged: _handleText,
                    ),
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("リスト"),
                ),
                Container(
                  width: _widthItem - _widthAddButton,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _checklistController,
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                ),
                _checklistController.text == ""
                    ? Container(
                        width: _widthAddButton,
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text('追加'),
                        ),
                      )
                    : Container(
                        width: _widthAddButton,
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              todoList.add(_checklistController.text);
                              _checklistController.text = "";
                            });
                          },
                          child: Text('追加'),
                        ),
                      ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text(""),
                ),
                Container(
                  width: _widthItem,
                  height: 500,
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            width: _widthItem - _widthTrashIcon - 20,
                            child: ListTile(
                              title: Text(todoList[index]),
                            ),
                          ),
                          Container(
                            width: _widthTrashIcon,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  todoList.removeAt(index);
                                });
                              },
                              // 表示アイコン
                              icon: Icon(Icons.delete_forever),
                              // アイコン色
                              // color: Colors.pink,
                              // サイズ
                              // iconSize: 64,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 日付選択Picker
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2015),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (picked != null) setState(() => _date = picked);
  }

  // 時刻選択Picker
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null) setState(() => _time = picked);
  }
}
