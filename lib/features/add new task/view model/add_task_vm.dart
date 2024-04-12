import 'package:intl/intl.dart';
import 'package:taskify/Data/hive_data_store.dart';
import 'package:taskify/utils/exports.dart';

class AddNewTaskProvider extends ChangeNotifier {
// Hive Data Box
  final hiveDataStore = HiveDataStore();

// Text Editing Controllers
  TextEditingController taskController = TextEditingController();
  TextEditingController subTaskController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  // Change the selected date format
  changeDateFormat({required DateTime date}) {
    final format = DateFormat("dd-MM-yyyy");
    dateController.text = format.format(date);
    selectedDate = date;
    notifyListeners();
  }

  // Form Items
  final task = FormItems(
    fieldName: "Task",
    hintText: "eg: Clean the Kitchen",
    errorMsg: "Please enter your task",
  );
  final subTask = FormItems(
    fieldName: "Sub Task",
    hintText: "eg: Do the dishes, Clean the fridge and Pantry",
    errorMsg: "Please enter your sub task",
  );
  final date = FormItems(
    fieldName: "Date",
    hintText: "eg: 12/11/2024",
    errorMsg: "Please select your date",
  );

// Validation
  String? taskValidation(String? val) => val!.isEmpty ? task.errorMsg : null;

  String? dateValidation(DateTime? val) => val == null ? date.errorMsg : null;

  // ? Submit Button

  // login loading state
  bool isSubmitLoad = false;

  // It changes the loading state
  setLoginLoading(bool loading) async {
    isSubmitLoad = loading;
    notifyListeners();
  }

  void submitForm(BuildContext context, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      setLoginLoading(true);
      final newTask = Tasks(
          id: const Uuid().v1(),
          task: taskController.text.trim(),
          subTask: subTaskController.text.trim(),
          date: selectedDate,
          isComplete: false);

      hiveDataStore.createTask(tasks: newTask);
      hiveDataStore.getTasks(id: "1");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
      setLoginLoading(false);
    }
  }
}
