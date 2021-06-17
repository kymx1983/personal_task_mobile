import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:personal_task_mobile/common/common.dart';

class Ticket extends StatefulWidget {
  // Ticket({Key key, this.title}) : super(key: key);
  // final String title;
  
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {

  // 期限
  DateTime _limit = new DateTime.now();

  // スヌーズ
  DateTime _snooze = new DateTime.now();

  @override
  Widget build(BuildContext context) {

    // サイズ関連
    final _size = MediaQuery.of(context).size;

    // 項目名の横幅
    final double _widthItemTitle = 80;

    // 項目の横幅（画面横幅 - 項目名の横幅 - マージン）
    final double _widthItem = _size.width - _widthItemTitle - 20;

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: _widthItemTitle,
                    padding: const EdgeInsets.all(10),
                    child: Text("チケット"),
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
                    child: Text("期限"),
                  ),
                  Text(
                    DateFormat(Common.formatDateOnly).format(_limit),
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
                          _selectLimit(context);
                        });
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
                    child: Text("メモ"),
                  ),
                  Container(
                    width: _widthItem,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
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
                      ),// onChanged: _handleText,
                    ),
                  ),
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
                    width: 90,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () { /* ボタンがタップされた時の処理 */ },
                      child: Text('追加'),
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: _widthItemTitle,
                    padding: const EdgeInsets.all(10),
                    child: Text("スヌーズ"),
                  ),
                  Text(
                    DateFormat(Common.formatDateOnly).format(_snooze),
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
                          _selectSnooze(context);
                        });
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
  // 日付選択Picker（期限）
  Future<Null> _selectLimit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _limit,
        firstDate: new DateTime.now(),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (picked != null) setState(() => _limit = picked);
  }

  // 日付選択Picker（スヌーズ）
  Future<Null> _selectSnooze(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _snooze,
        firstDate: new DateTime.now(),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (picked != null) setState(() => _snooze = picked);
  }
}
