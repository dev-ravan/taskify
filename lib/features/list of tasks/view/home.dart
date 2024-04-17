import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/common/constants.dart';
import 'package:taskify/utils/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  Task box
  late Box<Tasks> box;

  @override
  void initState() {
    box = Hive.box(HiveDataStore.boxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final provider = context.watch<HomeProvider>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.addNewTaskRoute(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildNameAndProfile(context),
                gapH(40),
                // Date Picker
                _buildCalender(context),
                gapH(20),
                Divider(
                  color: theme.tertiary,
                  indent: 40,
                  endIndent: 40,
                ),
                gapH(20),
                _buildTasksOnDate(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

//* Name and  profile
  Widget _buildNameAndProfile(BuildContext context) {
    final provider = context.watch<AuthViewModel>();
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myTexts.med16dmSans(
                text: "Welcome Back!",
                context: context,
                alterColor: theme.tertiary),
            myTexts.med24dmSans(
                text: globalUserName ?? "Not Defined", context: context),
          ],
        ),
        // Profile
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Theme(
                data: ThemeData(
                  dialogTheme: DialogTheme(backgroundColor: theme.background),
                ),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Row(
                    children: [
                      const Icon(Icons.logout_outlined),
                      gapW(10),
                      myTexts.bold18dmSans(
                          text: "Logout",
                          context: context,
                          alterColor: theme.secondary)
                    ],
                  ),
                  content: myTexts.med16dmSans(
                      text: "Are you sure, you want to logout?",
                      context: context,
                      alterColor: theme.secondary),
                  actions: [
                    OutlineCustomButton(
                        title: "Logout",

                        // Log out
                        onTap: () {
                          provider.logOutAccount();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
                        }),
                    ElevateCustomButton(
                      title: "Cancel",
                      onTap: () => Navigator.pop(context),
                      contentColor: theme.secondaryContainer,
                      bgColor: theme.primary,
                    )
                  ],
                ),
              ),
            );
          },
          child: CircleAvatar(
              backgroundColor: Colors.black12,
              radius: 20,
              child: Icon(
                Icons.logout_outlined,
                color: theme.secondary,
                size: 20,
              )),
        )
      ],
    );
  }

  //* Date Picker
  EasyDateTimeLine _buildCalender(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final theme = Theme.of(context).colorScheme;
    final inActiveDayStyle = GoogleFonts.dmSans(
        fontWeight: FontWeight.w600, fontSize: 16, color: theme.secondary);
    final activeDayStyle = GoogleFonts.dmSans(
        fontWeight: FontWeight.w600, fontSize: 16, color: theme.background);

    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
        provider.selectedDate = selectedDate;
        provider.dateFormatChange();
      },
      headerProps: const EasyHeaderProps(
        showHeader: false,
        monthPickerType: MonthPickerType.switcher,
        dateFormatter: DateFormatter.fullDateDMY(),
      ),
      dayProps: EasyDayProps(
        height: 70,
        width: 54,
        dayStructure: DayStructure.dayStrDayNum,
        // In active day style
        inactiveDayStyle: DayStyle(
          dayStrStyle: inActiveDayStyle,
          dayNumStyle: inActiveDayStyle,
        ),
        // Active day style
        activeDayStyle: DayStyle(
          dayStrStyle: activeDayStyle,
          dayNumStyle: activeDayStyle,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: theme.primary),
        ),
        // Today style
        todayStyle: DayStyle(
          dayStrStyle: inActiveDayStyle,
          dayNumStyle: inActiveDayStyle,
          decoration: BoxDecoration(
            border: Border.all(color: theme.primary),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
        ),
      ),
    );
  }

  //* Tasks on date
  Widget _buildTasksOnDate(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final theme = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
        valueListenable: HiveDataStore().listenToTask(),
        builder: (context, Box<Tasks> box, child) {
          // Reverse the list  for previous tasks shown on top
          var tasks = box.values.toList().reversed.toList();
          tasks.sort(((a, b) =>
              a.isComplete.toString().compareTo(b.isComplete.toString())));

          // Selected date tasks only showing
          tasks = tasks.where((task) {
            return task.date == provider.getSelectedDateWithoutTime();
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myTexts.med16dmSans(
                  text: "Tasks on",
                  context: context,
                  alterColor: theme.tertiary),
              myTexts.med24dmSans(
                  text: provider.formattedDate, context: context),
              gapH(30),
              tasks.isNotEmpty
                  ? _buildListOfTask(tasks, provider)
                  : _buildEmptyDataImg(context)
            ],
          );
        });
  }

  Center _buildEmptyDataImg(BuildContext context) {
    return Center(
      child: Column(
        children: [
          gapH(20),
          SvgPicture.asset(
            emptyImg,
            width: 300,
          ),
          gapH(20),
          myTexts.med16dmSans(text: "No tasks available..!", context: context)
        ],
      ),
    );
  }

  ListView _buildListOfTask(List<Tasks> tasks, HomeProvider provider) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int i) {
        var task = tasks[i];
        return Dismissible(
          direction: DismissDirection.horizontal,
          background: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline,
                color: Colors.red[200],
              ),
              const SizedBox(
                width: 8,
              ),
              myTexts.med16dmSans(text: "Delete Task", context: context)
            ],
          ),
          onDismissed: (direction) {
            // Delete task from hive box
            HiveDataStore().dalateTask(task: task);
          },
          key: Key(task.id),
          child: _roundedCheckBoxListTile(
            context: context,
            isChecked: task.isComplete,
            task: task.task,
            subTask: task.subTask,
            onChanged: (bool? val) {
              task.isComplete = val!;

              // Update the task
              HiveDataStore().updateTask(task: task);
              provider.taskStatusChange();
            },
          ),
        );
      },
    );
  }

// List tile checkbox container
  Widget _roundedCheckBoxListTile(
      {required BuildContext context,
      required bool isChecked,
      required String task,
      required String subTask,
      required Function(bool?)? onChanged}) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: isChecked ? theme.secondaryContainer : null,
          borderRadius: BorderRadius.circular(10),
          border: isChecked ? null : Border.all(color: theme.tertiary)),
      child: CheckboxListTile(
        title: myTexts.med18dmSans(
          context: context,
          text: task,
        ),
        subtitle: myTexts.med16dmSans(
            text: subTask, context: context, alterColor: theme.tertiary),
        value: isChecked,
        onChanged: onChanged,
        side: BorderSide(width: 1.0, color: theme.tertiary),
        checkboxShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
