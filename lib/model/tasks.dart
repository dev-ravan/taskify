import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  String uid;
  String task;
  String subTask;
  bool isDone;
  Timestamp taskOnDate;
  Timestamp createdOn;
  Timestamp updatedOn;

  Tasks({
    required this.uid,
    required this.task,
    required this.subTask,
    required this.isDone,
    required this.taskOnDate,
    required this.createdOn,
    required this.updatedOn,
  });

  Tasks copyWith({
    String? uid,
    String? task,
    String? subTask,
    bool? isDone,
    Timestamp? taskOnDate,
    Timestamp? createdOn,
    Timestamp? updatedOn,
  }) =>
      Tasks(
        uid: uid ?? this.uid,
        task: task ?? this.task,
        subTask: subTask ?? this.subTask,
        isDone: isDone ?? this.isDone,
        taskOnDate: taskOnDate ?? this.taskOnDate,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
      );

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        uid: json["uid"],
        task: json["task"],
        subTask: json["subTask"],
        isDone: json["isDone"],
        taskOnDate: json["taskOnDate"]! as Timestamp,
        createdOn: json["createdOn"]! as Timestamp,
        updatedOn: json["updatedOn"]! as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "task": task,
        "subTask": subTask,
        "isDone": isDone,
        "taskOnDate": taskOnDate,
        "createdOn": createdOn,
        "updatedOn": updatedOn,
      };
}
