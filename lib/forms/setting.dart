import 'package:flutter/material.dart';
import 'package:personal_task_mobile/common/common.dart';
import "package:intl/intl.dart";

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

enum SingingCharacter { day, week, month, target }

class _SettingState extends State<Setting> {
  List<Text> _list = [
    Text(
      "初期値",
      style: TextStyle(fontSize: 20),
    ),
  ];

  // 日付の指定を行うかどうかのフラグ
  bool _isDate = false;

  // 選択した日付
  DateTime _date = new DateTime.now();

  // 選択した時刻（初期値は9:00とする）
  TimeOfDay _time = new TimeOfDay(hour: 9, minute: 0);

  @override
  Widget build(BuildContext context) {
    // サイズ関連
    final _size = MediaQuery.of(context).size;

    // 項目名の横幅
    final double _widthItemTitle = 100;

    // 項目の横幅（画面横幅 - 項目名の横幅 - マージン）
    final double _widthItem = _size.width - _widthItemTitle - 20;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
          crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("メール"),
                ),
                Container(
                  width: _widthItem,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: true,
                    // 入力数
                    maxLength: 20,
                    obscureText: false,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      // hintText: "タスクを入力",
                      // labelText: "タスク",
                    ),
                    //パスワード
                    // onChanged: _handleText,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("パスワード"),
                ),
                Container(
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () { /* ボタンがタップされた時の処理 */ },
                      child: Text('パスワード変更'),
                    )
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("ユーザ名"),
                ),
                Container(
                  width: _widthItem,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: true,
                    // 入力数
                    maxLength: 20,
                    obscureText: false,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      // hintText: "タスクを入力",
                      // labelText: "タスク",
                    ),
                    //パスワード
                    // onChanged: _handleText,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: _widthItemTitle,
                  padding: const EdgeInsets.all(10),
                  child: Text("画像"),
                ),
                Container(
                    width: 140,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () { /* ボタンがタップされた時の処理 */ },
                      child: Text('アップロード'),
                    )
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
