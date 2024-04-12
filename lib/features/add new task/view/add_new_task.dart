import 'package:taskify/utils/exports.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddNewTaskProvider>();
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: myTexts.med24dmSans(text: "Add New Task", context: context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                gapH(50),
                // Task
                MyTextField(
                    fieldName: provider.task.fieldName,
                    hintText: provider.task.hintText,
                    validator: (val) => provider.taskValidation(val),
                    controller: provider.taskController),
                gapH(30),
                // Date
                DatePicker(
                  fieldName: provider.date.fieldName,
                  hintText: provider.date.hintText,
                  controller: provider.dateController,
                  onTap: () async {
                    final DateTime? datePick = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    provider.changeDateFormat(date: datePick!);
                  },
                ),
                gapH(30),
                // Sub Task
                MyTextField(
                    maxLines: 4,
                    fieldName: provider.subTask.fieldName,
                    hintText: provider.subTask.hintText,
                    controller: provider.subTaskController),
                gapH(30),
                MyButton(
                    title: "Submit",
                    onTap: () => provider.submitForm(context, formKey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
