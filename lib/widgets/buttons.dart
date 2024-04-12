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

class OutlineCustomButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const OutlineCustomButton(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap as void Function(),
        child: myTexts.med16dmSans(text: title, context: context));
  }
}

class ElevateCustomButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color? bgColor;
  final Color? contentColor;
  const ElevateCustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.bgColor,
      this.contentColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? theme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap as void Function(),
        child: myTexts.med16dmSans(
            text: title,
            context: context,
            alterColor: contentColor ?? theme.secondary));
  }
}
