import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:taskify/utils/exports.dart';

showToast(
    {required String message,
    IconData? icon,
    Color? iconColor,
    required BuildContext context}) {
  return DelightToastBar(
    autoDismiss: true,
    position: DelightSnackbarPosition.top,
    builder: (context) => ToastCard(
      color: Colors.white,
      title: myTexts.med16dmSans(
          text: message, context: context, alterColor: Colors.black87),
      leading: Icon(
        icon,
        color: iconColor,
      ),
    ),
  ).show(context);
}
