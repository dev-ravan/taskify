import 'package:taskify/utils/exports.dart';
part 'tasks.g.dart';

@HiveType(typeId: 0)
class Tasks extends HiveObject {
  Tasks(
      {required this.id,
      required this.task,
      required this.subTask,
      required this.date,
      required this.isComplete});

  @HiveField(0) //Id
  final String id;
  @HiveField(1) // Task
  String task;
  @HiveField(2) // Sub Task
  String subTask;
  @HiveField(3) // Task Date
  DateTime date;
  @HiveField(4) // Task Completed Status
  bool isComplete;

  factory Tasks.create(
          {required String? task, required String? subTask, DateTime? date}) =>
      Tasks(
          id: const Uuid().v1(),
          task: task ?? "",
          subTask: subTask ?? "",
          date: date ?? DateTime.now(),
          isComplete: false);
}
