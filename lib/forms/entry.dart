import 'package:flutter/material.dart';
import 'package:personal_task_mobile/common/common.dart';
import "package:intl/intl.dart";

class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

enum SingingCharacter { day, week, month, target }

class _EntryState extends State<Entry> {
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
    final double _widthItemTitle = 80;

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
