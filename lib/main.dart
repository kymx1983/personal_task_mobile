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
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => MyHomePage(),
        '/search': (BuildContext context) => Search(),
        '/entry': (BuildContext context) => Entry(),
        '/routine': (BuildContext context) => Routine(),
        '/calender': (BuildContext context) => Calender(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PersonalTask"),
      ),
      body: Container(
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
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Entry(),
                    )
                );
              },
            ),
          ],
        ),
      ),
        bottomNavigationBar: Footer(Footer.iconHome) // <- Footer Widget (Footer Instance)を指定
    );
  }
}
