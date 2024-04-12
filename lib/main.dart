import 'package:firebase_core/firebase_core.dart';
import 'package:taskify/Data/hive_data_store.dart';
import 'package:taskify/common/splash.dart';
import 'package:taskify/features/list%20of%20tasks/view%20model/home_vm.dart';
import 'package:taskify/firebase_options.dart';
import 'package:taskify/utils/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Initialize hive db before run the app
  await Hive.initFlutter();

  // Register hive adopter
  Hive.registerAdapter<Tasks>(TasksAdapter());

  // Open the tasks box
  await Hive.openBox<Tasks>(HiveDataStore.boxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<AddNewTaskProvider>(
            create: (_) => AddNewTaskProvider()),
      ],
      child: MaterialApp(
        title: 'Taskify',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
