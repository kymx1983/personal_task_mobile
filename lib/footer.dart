import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Footer extends StatefulWidget {
  int index = 0;

  Footer(int index) {
    this.index = index;
  }

  @override
  _Footer createState() => _Footer(index);
}

class _Footer extends State {
  int index;
  _Footer(int index){
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
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
      currentIndex: this.index,
      selectedItemColor: Colors.blue,
    );
  }
}