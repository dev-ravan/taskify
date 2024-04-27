import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskify/model/tasks.dart';
import 'package:taskify/model/user_profile.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _tasks;
  late final CollectionReference _users;

  DatabaseService() {
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    // User Collection
    _users = db.collection("users").withConverter<UserProfile>(
          fromFirestore: (snapshot, _) =>
              UserProfile.fromJson(snapshot.data()!),
          toFirestore: (users, _) => users.toJson(),
        );

    // Tasks Collection
    _tasks = db.collection("tasks").withConverter<Tasks>(
          fromFirestore: (snapshot, _) => Tasks.fromJson(snapshot.data()!),
          toFirestore: (tasks, _) => tasks.toJson(),
        );
  }

// Add user details
  Future<void> addUser({required UserProfile user}) async {
    await _users.doc(user.uid).set(user);
  }

// Get tasks details
  Stream<QuerySnapshot> getTasks() => _tasks.snapshots();

// Add task
  void addTask(Tasks tasks) async {
    _tasks.add(tasks);
  }

// Update task
  void updateTask(String taskId, Tasks task) async {
    _tasks.doc(taskId).update(task.toJson());
  }

// Delete task
  void deleteTask(String taskId) async {
    _tasks.doc(taskId).delete();
  }
}
