import 'package:flutter/material.dart';
import 'package:personal_task_mobile/forms/Calender.dart';
import 'package:personal_task_mobile/forms/entry.dart';
import 'package:personal_task_mobile/forms/home.dart';
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
  String title = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  //
  final String title = "";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  Widget _mainWidget = new Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PersonalTask"),
      ),
      body: _mainWidget,
      bottomNavigationBar: _buildFooter(context),
    );
  }

  BottomNavigationBar _buildFooter(BuildContext context) {
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
              _mainWidget = new Home();
            });
            break;
          case Footer.iconSearch:
            setState(() {
              _mainWidget = new Search();
            });
            break;
          case Footer.iconAdd:
            setState(() {
              _mainWidget = new Entry();
            });
            break;
          case Footer.iconWatchLater:
            // ルーティン画面に遷移
            setState(() {
              _mainWidget = new Routine();
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
}
