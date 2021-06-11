import 'package:flutter/material.dart';
import 'package:personal_task_mobile/common/common.dart';
import "package:intl/intl.dart";

class Routine extends StatefulWidget {
  // Routine({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _RoutineState createState() => _RoutineState();
}

enum SingingCharacter { day, week, month, target }

class _RoutineState extends State<Routine> {
  SingingCharacter? _character = SingingCharacter.day;

  // 曜日
  List<String> _weekOrg = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"];

  // 選択した日付
  DateTime _date = new DateTime.now();

  // 選択した時刻（初期値は9:00とする）
  TimeOfDay _time = new TimeOfDay(hour: 9, minute: 0);

  int? _dayOfMonth = 0;
  int? _week= 0;

  List<DropdownMenuItem<int>> _weeks = [];
  List<DropdownMenuItem<int>> _days = [];

  @override
  void initState() {
    for (int i = 0; i < _weekOrg.length; i++) {
      _weeks
        ..add(DropdownMenuItem(
          child: Text(
            _weekOrg[i],
            style: TextStyle(fontSize: 14.0),
          ),
          value: i,
        ));
    }
    _week = _weeks[0].value;

    for (int i = 1; i <= 31; i++) {
      _days
        ..add(DropdownMenuItem(
          child: Text(
            i.toString() + "日",
            style: TextStyle(fontSize: 14.0),
          ),
          value: i,
        ));
    }
    _dayOfMonth = _days[0].value;
  }

  @override
  Widget build(BuildContext context) {
    // サイズ関連
    final _size = MediaQuery.of(context).size;

    // 項目名の横幅
    final double _widthItemTitle = 80;

    // 項目の横幅（画面横幅 - 項目名の横幅 - マージン）
    final double _widthItem = _size.width - _widthItemTitle - 20;

    bool _isDay = true;
    bool _isWeek = false;

    String _type = 'favorite';

    void _handleRadio(String e) {
      setState(() {
        print(e);
        String _type = 'week';
      });
    }

    IconData _changeIcon(String e) {
      IconData icon;
      switch (e) {
        case 'thumb_up':
          icon = Icons.thumb_up;
          break;
        case 'favorite':
          icon = Icons.favorite;
          break;
        default:
          icon = Icons.thumb_up;
      }
      return icon;
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("タスク追加"),
      // ),
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
                    style: TextStyle(color: Colors.red),
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
                  child: Text("メモ"),
                ),
                Container(
                  width: _widthItem,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    enabled: true,
                    // 入力数
                    maxLength: 300,
                    style: TextStyle(color: Colors.red),
                    obscureText: false,
                    maxLines: 2,
                    decoration: const InputDecoration(
                        // hintText: "メモを入力",
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
                  child: Text("サイクル"),
                ),
                Container(
                  width: _widthItem,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio<SingingCharacter>(
                            value: SingingCharacter.day,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                          Container(
                            width: _widthItemTitle,
                            child: Text('毎日'),
                          ),
                          if (_character == SingingCharacter.day)
                            Row(
                              children: [
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
                      Row(
                        children: [
                          Radio<SingingCharacter>(
                            value: SingingCharacter.week,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                          Container(
                            width: _widthItemTitle,
                            child: Text('毎週'),
                          ),
                          if (_character == SingingCharacter.week)
                            Container(
                              width: _widthItemTitle,
                              child: DropdownButton(
                                items: _weeks,
                                value: _week,
                                onChanged: (value) => {
                                  setState(() {
                                    _week = int.parse(value.toString());
                                  }),
                                },
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<SingingCharacter>(
                            value: SingingCharacter.month,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                          Container(
                            width: _widthItemTitle,
                            child: Text('毎月'),
                          ),
                          if (_character == SingingCharacter.month)
                            Container(
                              width: 80,
                              child: DropdownButton(
                                items: _days,
                                value: _dayOfMonth,
                                onChanged: (value) => {
                                  setState(() {
                                    _dayOfMonth = int.parse(value.toString());
                                  }),
                                },
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<SingingCharacter>(
                            value: SingingCharacter.target,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                          Container(
                            width: _widthItemTitle,
                            child: Text('指定日'),
                          ),
                          if (_character == SingingCharacter.target)
                          Row(
                            children: [
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
                        ],
                      ),
                    ],
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
