import 'package:flutter/material.dart';
import 'package:personal_task_mobile/footer.dart';

class Routine extends StatefulWidget {
  // Routine({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _RoutineState createState() => _RoutineState();
}

enum SingingCharacter { day, week, month, target }

class _RoutineState extends State<Routine> {
  SingingCharacter? _character = SingingCharacter.day;

  int? _week = 0;
  List<DropdownMenuItem<int>> _weeks = [];

  @override
  void initState() {
    _weeks..add(DropdownMenuItem(
      child: Text('月曜日', style: TextStyle(fontSize: 14.0),),
      value: 1,
    ));

    _weeks..add(DropdownMenuItem(
      child: Text('火曜日', style: TextStyle(fontSize: 14.0),),
      value: 2,
    ));

    _weeks..add(DropdownMenuItem(
      child: Text('水曜日', style: TextStyle(fontSize: 14.0),),
      value: 3,
    ));

    _weeks..add(DropdownMenuItem(
      child: Text('木曜日', style: TextStyle(fontSize: 14.0),),
      value: 4,
    ));

    _weeks..add(DropdownMenuItem(
      child: Text('金曜日', style: TextStyle(fontSize: 14.0),),
      value: 5,
    ));

    _weeks..add(DropdownMenuItem(
      child: Text('土曜日', style: TextStyle(fontSize: 14.0),),
      value: 6,
    ));

    _weeks..add(DropdownMenuItem(
      child: Text('日曜日', style: TextStyle(fontSize: 14.0),),
      value: 7,
    ));

    _week = _weeks[0].value;
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
                            width: 50,
                            child: Text('日次'),
                          ),
                          Container(
                            width: 40,
                            child: TextFormField(
                              enabled: true,
                              // 入力数
                              maxLength: 2,
                              style: TextStyle(color: Colors.red),
                              obscureText: false,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                // hintText: "メモを入力",
                                // labelText: "タスク",
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text('時'),
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
                            width: 50,
                            child: Text('週次'),
                          ),
                          Container(
                            width: 80,
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
                            width: 50,
                            child: Text('月次'),
                          ),
                          Container(
                            width: 40,
                            child: TextFormField(
                              enabled: true,
                              // 入力数
                              maxLength: 2,
                              style: TextStyle(color: Colors.red),
                              obscureText: false,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                // hintText: "メモを入力",
                                // labelText: "タスク",
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text('日'),
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
                            width: 50,
                            child: Text('指定日'),
                          ),
                          Container(
                            width: 40,
                            child: TextFormField(
                              enabled: true,
                              // 入力数
                              maxLength: 2,
                              style: TextStyle(color: Colors.red),
                              obscureText: false,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                // hintText: "メモを入力",
                                // labelText: "タスク",
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text('日'),
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
}
