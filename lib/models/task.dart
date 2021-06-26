class Task{
  int id = 0;
  int userId = 0;
  String title = "";
  DateTime targetDate = DateTime.now();
  String memo = "";
  int status = 0;

  bool isCheck = false;
  bool isDoing = false;

  Task.init();

  static Task setData(dynamic data) {

    Task task = Task.init();

    task.id =  data['id'];
    task.userId =  data['user_id'];
    task.title =  data['title'];
    // task.targetDate =  new DateTime(data['target_date']);
    task.memo =  data['memo'];
    task.status =  data['status'];

    return task;

  }

  static List<Task> setList(Map<String,dynamic> jsonList) {
    List<Task> list = [];

    for(var data in jsonList['data']){
      Task task = Task.init();

      task.id =  data['id'];
      task.userId =  data['user_id'];
      task.title =  data['title'];
      // task.targetDate =  new DateTime(data['target_date']);
      task.memo =  data['memo'];
      task.status =  data['status'];

      list.add(task);
    }

    return list;

  }
}