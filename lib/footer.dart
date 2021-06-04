import 'package:flutter/material.dart';
import 'package:personal_task_mobile/forms/Calender.dart';
import 'package:personal_task_mobile/forms/entry.dart';
import 'package:personal_task_mobile/forms/routine.dart';
import 'package:personal_task_mobile/forms/search.dart';
import 'package:personal_task_mobile/main.dart';

// ignore: must_be_immutable
class Footer extends StatefulWidget {
  int index = 0;

  static const int iconHome = 0;
  static const int iconSearch = 1;
  static const int iconAdd = 2;
  static const int iconWatchLater = 3;
  static const int iconCalenderToday = 4;

  Footer(int index) {
    this.index = index;
  }

  @override
  _Footer createState() => _Footer(index);
}

class _Footer extends State {
  int index;

  _Footer(int index) {
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
      onTap: (int index) {
        print(index);

        switch (index) {
          case Footer.iconHome:
          // ホーム画面に遷移
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
            break;
            break;
          case Footer.iconSearch:
            // 検索画面に遷移
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ));
            break;
          case Footer.iconAdd:
            // 登録画面に遷移
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Entry(),
                ));
            break;
          case Footer.iconWatchLater:
          // ルーティン画面に遷移
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Routine(),
                ));
            break;
          case Footer.iconCalenderToday:
          // ルーティン画面に遷移
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Calender(),
                ));
            break;
        }

        if (index == Footer.iconHome) {
          // トップページへ遷移
          // MaterialPageRoute(builder: (context) => MyHomePage());
        } else if (index == Footer.iconAdd) {
          print("登録");
          // 登録ページへ遷移

        }
      },
    );
  }
}
