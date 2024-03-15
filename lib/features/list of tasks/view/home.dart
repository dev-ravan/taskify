import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:taskify/utils/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
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
    );
  }

// Name and  Profile
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

  // Date Picker

  EasyDateTimeLine _buildCalender(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final inActiveDayStyle = GoogleFonts.dmSans(
        fontWeight: FontWeight.w600, fontSize: 16, color: theme.secondary);
    final activeDayStyle = GoogleFonts.dmSans(
        fontWeight: FontWeight.w600, fontSize: 16, color: theme.background);

    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
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
          decoration: BoxDecoration(
            border: Border.all(color: theme.primary),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
        ),
      ),
    );
  }

  // Task on date
  Widget _buildTasksOnDate(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myTexts.med16dmSans(
            text: "Tasks on", context: context, alterColor: theme.tertiary),
        myTexts.med24dmSans(text: "Monday Nov 12", context: context),
      ],
    );
  }
}
