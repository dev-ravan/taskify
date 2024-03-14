import 'package:taskify/utils/exports.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const MyButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: onTap as void Function(),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 50),
        backgroundColor: theme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: myTexts.bold18dmSans(text: title, context: context),
    );
  }
}
