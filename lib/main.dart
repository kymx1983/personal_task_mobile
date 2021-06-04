import 'package:flutter/material.dart';
import 'package:personal_task_mobile/forms/Calender.dart';
import 'package:personal_task_mobile/forms/entry.dart';
import 'package:personal_task_mobile/forms/routine.dart';
import 'package:personal_task_mobile/forms/search.dart';
import 'footer.dart';

void main() {
  runApp(
    // MyApp(),
    new MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyHomePage(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isCheck = false;
  bool _isDoing = false;
  int _index = 0;

  Widget _mainWidget;

  @override
  // 初期処理
  void initState() {
    _mainWidget = _buildHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PersonalTask"),
      ),
      body: _mainWidget,
      bottomNavigationBar: _buildFooter(),
    );
  }

  BottomNavigationBar _buildFooter() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '検索',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: '追加',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later),
          label: 'ルーティン',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'カレンダー',
        ),
      ],
      currentIndex: _index,
      selectedItemColor: Colors.blue,
      onTap: (int index) {
        print(index);

        switch (index) {
          case Footer.iconHome:
            setState(() {
              _mainWidget = _buildHomePage();
            });
            break;
          case Footer.iconSearch:
            setState(() {
              _mainWidget = Search.buildSearch();
            });
            break;
          case Footer.iconAdd:
            setState(() {
              _mainWidget = Entry.buildEntry();
            });
            break;
          case Footer.iconWatchLater:
            // ルーティン画面に遷移
            setState(() {
              _mainWidget = Routine.buildRoutine();
            });
            break;
          case Footer.iconCalenderToday:
            // カレンダー画面に遷移
            setState(() {
              _mainWidget = Calender.buildCalender();
            });
            break;
        }
        this._index = index;
      },
    );
  }

  Widget _buildHomePage() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 330,
                child: CheckboxListTile(
                  activeColor: Colors.grey,
                  title: Text('請求書作成',
                      style: TextStyle(
                          decoration: _isCheck
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: _isCheck ? Colors.grey : Colors.black)),
                  subtitle: Text(
                    'plan 2021.06.04  due 2021.06.30',
                    style: TextStyle(
                        decoration: _isCheck
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: _isCheck ? Colors.grey : Colors.black45),
                  ),
                  // secondary: new Icon(
                  //   Icons.thumb_up,
                  //   color: _isCheck ? Colors.orange[700] : Colors.grey[500],
                  // ),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _isCheck,
                  onChanged: (bool value) {
                    setState(() {
                      _isCheck = value;
                    });
                  },
                ),
              ),
              Container(
                width: 40,
                // child: Text("あああ"),
                child: IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: _isCheck
                        ? Colors.grey
                        : _isDoing
                            ? Colors.blue
                            : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isDoing = !_isDoing;
                    });
                  },
                ),
              ),
              Container(
                width: 40,
                // child: Text("あああ"),
                child: IconButton(
                  icon: Icon(Icons.more_vert),
                ),
              ),
            ],
          ),
          RaisedButton(
            child: Text('次へ'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => Entry(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
