import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:taskify/features/list%20of%20tasks/view%20model/home_vm.dart';
import 'package:taskify/utils/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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

//* Name and  Profile
  Widget _buildNameAndProfile(BuildContext context) {
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
            myTexts.med24dmSans(text: "Danial Alexander", context: context),
          ],
        ),
        // Profile
        CircleAvatar(
          backgroundColor: theme.tertiary,
          radius: 26,
          child: const CircleAvatar(
            backgroundImage: AssetImage(profileImg),
            radius: 25,
          ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myTexts.med16dmSans(
            text: "Tasks on", context: context, alterColor: theme.tertiary),
        myTexts.med24dmSans(text: provider.formattedDate, context: context),
        gapH(30),
        ListView.builder(
          shrinkWrap: true,
          itemCount: provider.taskList.length,
          itemBuilder: (BuildContext context, int i) {
            return _roundedCheckBoxListTile(
              context: context,
              isChecked: provider.taskList[i].isChecked,
              task: provider.taskList[i].task,
              subTask: provider.taskList[i].subTask,
              onChanged: (bool? val) {
                provider.taskList[i].isChecked = val!;
                provider.taskStatusChange();
              },
            );
          },
        )
      ],
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
