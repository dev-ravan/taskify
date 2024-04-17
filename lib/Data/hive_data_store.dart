// import 'package:flutter/foundation.dart';
// import 'package:taskify/utils/exports.dart';

// class HiveDataStore {
//   // Box Name - String
//   static const boxName = "taskBox";

//   // Our box saved all the data inside
//   final Box<Tasks> box = Hive.box<Tasks>(boxName);

//   // Create Task
//   Future<void> createTask({required Tasks tasks}) async {
//     await box.put(tasks.id, tasks);
//   }

//   // Show Tasks
//   Future<Tasks?> getTasks({required String id}) async {
//     return box.get(id);
//   }

//   // Update task
//   Future<void> updateTask({required Tasks task}) async {
//     await task.save();
//   }

//   // Delete task
//   Future<void> dalateTask({required Tasks task}) async {
//     await task.delete();
//   }

//   // Listen task changes
//   ValueListenable<Box<Tasks>> listenToTask() => box.listenable();
// }
