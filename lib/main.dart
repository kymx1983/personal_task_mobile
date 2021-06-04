import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
        title: Text(widget.title),
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
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
