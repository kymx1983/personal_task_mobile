import 'package:flutter/material.dart';
import 'package:personal_task_mobile/footer.dart';

class Calender extends StatefulWidget {
  Calender({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カレンダー"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
        bottomNavigationBar: Footer(Footer.iconCalenderToday) // <- Footer Widget (Footer Instance)を指定// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
