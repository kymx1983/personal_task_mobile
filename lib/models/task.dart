class Task{
  int id = 0;
  String title = "";
  String memo = "";
  DateTime plan = DateTime.now();
  DateTime due = DateTime.now();

  bool isCheck = false;
  bool isDoing = false;

  Task.init();
}