import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:taskify/common/constants.dart';
import 'package:taskify/model/tasks.dart';
import 'package:taskify/model/user_profile.dart';
import 'package:taskify/services/auth_service.dart';

class DatabaseService {
  final GetIt _getIt = GetIt.instance;
  final db = FirebaseFirestore.instance;

  late AuthService _authService;
  late final CollectionReference _tasks;
  late final CollectionReference _users;

  DatabaseService() {
    _authService = _getIt.get<AuthService>();
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

// Get single user details
  Future<String> getUserName() async {
    try {
      globalUserName = await _users
          .doc(_authService.user!.uid)
          .get()
          .then((value) => value["name"]);
      print(globalUserName);
      return globalUserName;
    } catch (e) {
      print(e);
    }
    return throw Exception("Sorry :(");
  }

  Stream<QuerySnapshot<UserProfile>> getSingleUser() {
    return _users.where("uid", isEqualTo: _authService.user!.uid).snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }

// Get tasks details
  Stream<QuerySnapshot> getTasks() =>
      _tasks.where("uid", isEqualTo: _authService.user!.uid).snapshots();

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
