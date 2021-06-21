import 'package:flutter/material.dart';
import 'package:personal_task_mobile/enums/footer_items.dart';
import 'package:personal_task_mobile/forms/setting.dart';
import 'package:personal_task_mobile/forms/entry.dart';
import 'package:personal_task_mobile/forms/home.dart';
import 'package:personal_task_mobile/forms/routine.dart';
import 'package:personal_task_mobile/forms/ticket.dart';

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
          icon: Icon(Icons.check_box_outlined),
          label: 'タスク',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'ルーティン',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'チケット',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '設定',
        ),
      ],
      currentIndex: _index,
      selectedItemColor: Colors.blue,
      onTap: (int index) {
        print(index);

        switch (index) {
          case FooterItems.home:
            setState(() {
              _mainWidget = new Home();
            });
            break;
          case FooterItems.info:
            setState(() {
              _mainWidget = new Ticket();
            });
            break;
          case FooterItems.routine:
            // ルーティン画面に遷移
            setState(() {
              _mainWidget = new Routine();
            });
            break;
          case FooterItems.setting:
            // カレンダー画面に遷移
            setState(() {
              _mainWidget = new Setting();
            });
            break;
        }
        this._index = index;
      },
    );
  }
}
