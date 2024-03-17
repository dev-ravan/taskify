import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:taskify/utils/exports.dart';

class MyTextField extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final bool? obscure;
  const MyTextField(
      {super.key,
      required this.fieldName,
      required this.hintText,
      required this.controller,
      this.validator,
      this.obscure,
      this.maxLines,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myTexts.med18dmSans(text: fieldName, context: context),
        gap(5),
        TextFormField(
          controller: controller,
          maxLines: maxLines ?? 1,
          validator: validator,
          obscureText: obscure ?? false,
          obscuringCharacter: "*",
          textAlignVertical: TextAlignVertical.center,
          cursorWidth: 2,
          inputFormatters: formatter,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.surface,
            isDense: true,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: GoogleFonts.roboto(
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            hintText: hintText,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0.2, color: theme.tertiary)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: theme.tertiary,
                width: 0.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: theme.primary)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
          ),
        ),
      ],
    );
  }
}

class DatePickField extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final TextEditingController controller;
  final String? Function(DateTime?)? validator;
  final List<TextInputFormatter>? formatter;

  const DatePickField(
      {super.key,
      required this.fieldName,
      required this.hintText,
      required this.controller,
      this.validator,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final format = DateFormat("yyyy/MM/dd");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myTexts.med18dmSans(text: fieldName, context: context),
        gap(5),
        DateTimeField(
          controller: controller,
          validator: validator,
          cursorWidth: 2,
          inputFormatters: formatter,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_month_outlined,
              color: theme.secondary,
              size: 24,
            ),
            filled: true,
            fillColor: theme.surface,
            isDense: true,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: GoogleFonts.roboto(
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            hintText: hintText,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0.2, color: theme.tertiary)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: theme.tertiary,
                width: 0.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: theme.primary)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
          ),
          format: format,
          onShowPicker: (BuildContext context, DateTime? currentValue) =>
              showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          ),
        ),
      ],
    );
  }
}
