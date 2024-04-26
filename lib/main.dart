import 'package:taskify/app/app.dart';
import 'package:taskify/utils/depentency_injection.dart';
import 'package:taskify/utils/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setup();

// Initialize hive db before run the app
  await Hive.initFlutter();

  runApp(const MyApp());
}

Future<void> setup() async {
  await setupFirebase();
  await registerServices();
}
