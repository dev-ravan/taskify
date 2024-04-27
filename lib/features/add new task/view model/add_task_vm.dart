import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:taskify/model/tasks.dart';
import 'package:taskify/services/database_service.dart';
import 'package:taskify/utils/exports.dart';

class AddNewTaskProvider extends ChangeNotifier {
// Firebase db
  DatabaseService dbService = DatabaseService();

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

      try {
        // Task payload model
        final newTask = Tasks(
          task: taskController.text.trim(),
          subTask: subTaskController.text.trim(),
          createdOn: Timestamp.now(),
          isDone: false,
          updatedOn: Timestamp.now(),
          taskOnDate: Timestamp.fromDate(selectedDate),
        );

        // Add task to hive box
        dbService.addTask(newTask);

        // After this screen will navigate to home
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);

        // Clear the form fields
        resetForm();
      } catch (e) {
        print(e);
      }

      setLoginLoading(false);
    }
  }

  resetForm() {
    taskController.clear();
    dateController.clear();
    subTaskController.clear();
  }
}
