import 'package:google_fonts/google_fonts.dart';
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
}
