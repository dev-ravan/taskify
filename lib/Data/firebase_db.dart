import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskify/model/tasks.dart';

const String TASK_COLLECTION_REF = "tasks";

class FirebaseService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _tasks;

  FirebaseService() {
    _tasks = db.collection(TASK_COLLECTION_REF).withConverter<Tasks>(
          fromFirestore: (snapshot, _) => Tasks.fromJson(snapshot.data()!),
          toFirestore: (tasks, _) => tasks.toJson(),
        );
  }

// Get tasks data
  Stream<QuerySnapshot> getTasks() => _tasks.snapshots();

// Add Tasks
  void addTask(Tasks tasks) async {
    _tasks.add(tasks);
  }

// Update task
  void updateTask(String taskId, Tasks task) async {
    _tasks.doc(taskId).update(task.toJson());
  }

// Update task
  void deleteTask(String taskId) async {
    _tasks.doc(taskId).delete();
  }
}
