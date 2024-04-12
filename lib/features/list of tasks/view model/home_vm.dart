import 'package:intl/intl.dart';
import 'package:taskify/features/add%20new%20task/view/add_new_task.dart';
import 'package:taskify/utils/exports.dart';

class HomeProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('EEEE d MMM').format(DateTime.now());

// change date format
  dateFormatChange() {
    formattedDate = DateFormat('EEEE d MMM').format(selectedDate);
    notifyListeners();
  }

// this method update state of the task checked or not
  taskStatusChange() {
    notifyListeners();
  }

// Navigate to add new task
  addNewTaskRoute(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }

  List taskList = [];

// // Task List
//   List<TaskListModel> taskList = [
//     TaskListModel(
//         task: 'Grocery List',
//         subTask: 'Buy Fruits, Buy Vegetables, Buy Dairy Products',
//         isChecked: false),
//     TaskListModel(
//         task: 'Birthday Party Organization',
//         subTask: 'Send Invitations, Decorate Venue, Arrange Catering',
//         isChecked: false),
//     TaskListModel(
//         task: 'Weekend Getaway Planning',
//         subTask: 'Book Accommodations, Pack Essentials, Plan Activities',
//         isChecked: false),
//     TaskListModel(
//         task: 'Study Session Schedule',
//         subTask: 'Review Notes, Complete Assignments,Practice Problems',
//         isChecked: false),
//     TaskListModel(
//         task: 'Work Presentation Organization',
//         subTask: 'Create Slides, Rehearse Presentation, Prepare Talking Points',
//         isChecked: false),
//     TaskListModel(
//         task: 'House Cleaning',
//         subTask: 'Tidy Living Room, Vacuum Carpets, Do Laundry',
//         isChecked: false),
//     TaskListModel(
//         task: 'Fitness Routine Planning',
//         subTask: 'Cardio Exercises, Strength Training, Stretching',
//         isChecked: false),
//     TaskListModel(
//         task: 'Financial Budgeting',
//         subTask: 'Track Expenses',
//         isChecked: false),
//     TaskListModel(
//         task: 'Financial Budgeting',
//         subTask: 'Create Savings Plan',
//         isChecked: false),
//     TaskListModel(
//         task: 'Financial Budgeting', subTask: 'Pay Bills', isChecked: false),
//     TaskListModel(
//         task: 'Charity Event Organization',
//         subTask: 'Recruit Volunteers',
//         isChecked: false),
//     TaskListModel(
//         task: 'DIY Home Improvement Project',
//         subTask: 'Complete Project Steps',
//         isChecked: false),
//   ];
}
