import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:taskify/firebase_options.dart';
import 'package:taskify/services/auth_service.dart';
import 'package:taskify/services/database_service.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// Get data from the cache
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<DatabaseService>(DatabaseService());
}
