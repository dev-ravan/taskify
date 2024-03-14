import 'package:taskify/utils/exports.dart';

class AuthProvider extends ChangeNotifier {
  // ! [ Login Section Data ]

  final loginTitle = "Login";
  final loginDesc = "Login to your account";

  bool isObscure = true;

  // Text Editing Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final email = FormItems(
      fieldName: "Email ID",
      errorMsg: "Please enter your mail id",
      hintText: "eg: ravan@gmail.com",
      regExp: r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'\.(com|net|org|in|edu|gov)$'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  final password = FormItems(
      fieldName: "Password",
      hintText: "eg: ravan@123",
      errorMsg: "Please enter your password",
      regExp: r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  // Login validation
  String? emailValidation(String? val) {
    if (val!.isEmpty) {
      return email.errorMsg;
    } else if (!RegExp(email.regExp).hasMatch(val)) {
      return "It's not a valid mail id";
    }
    return null;
  }

  String? passwordValidation(String? val) => val!.isEmpty
      ? password.errorMsg
      : val.length <= 8
          ? "Password should be 8 digits"
          : null;

  // login loading state
  bool isLoginLoad = false;

  // It changes the loading state
  setLoginLoading(bool loading) async {
    isLoginLoad = loading;
    notifyListeners();
  }

  // ? Login Button
  void submitLoginForm(BuildContext context, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      setLoginLoading(true);

      setLoginLoading(false);
    }
  }

  // ? Register Button
  void registerClick(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  // ! [ Register Section Data ]

  final registerTitle = "Register";
  final registerDesc = "Create your account";

  // Text Editing Controllers
  final regEmailController = TextEditingController();
  final regPasswordController = TextEditingController();
  final userNameController = TextEditingController();

  // Form Items
  final userName = FormItems(
    fieldName: "Name",
    hintText: "eg: Ravan",
    errorMsg: "Please enter your name",
  );
// Validation
  String? userNameValidation(String? val) =>
      val!.isEmpty ? userName.errorMsg : null;
}
