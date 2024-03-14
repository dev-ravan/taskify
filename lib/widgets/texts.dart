import 'package:taskify/utils/exports.dart';

final myTexts = MyTexts();

class MyTexts {
  //* Medium dmSans text with 32 font size
  Text med32dmSans(
      {required String text,
      Color? alterColor,
      required BuildContext context}) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: alterColor ?? Theme.of(context).colorScheme.secondary),
    );
  }

  //* Medium dmSans text with 18 font size
  Text med18dmSans(
      {required String text,
      Color? alterColor,
      TextDecoration? textDecoration,
      required BuildContext context}) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        decoration: textDecoration ?? TextDecoration.none,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: alterColor ?? Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  //* Medium dmSans text with 24 font size
  Text med24dmSans(
      {required String text,
      Color? alterColor,
      required BuildContext context}) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: alterColor ?? Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  //* Medium dmSans text with 16 font size
  Text med16dmSans(
      {required String text,
      Color? alterColor,
      required BuildContext context}) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: alterColor ?? Theme.of(context).colorScheme.tertiary),
    );
  }

  //* Bold dmSans text with 18 font size
  Text bold18dmSans(
      {required String text,
      Color? alterColor,
      required BuildContext context}) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: alterColor ?? Theme.of(context).colorScheme.background),
    );
  }
}
