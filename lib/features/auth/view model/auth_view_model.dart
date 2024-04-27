// ignore_for_file: use_build_context_synchronously

import 'package:get_it/get_it.dart';
import 'package:taskify/model/user_profile.dart';
import 'package:taskify/services/auth_service.dart';
import 'package:taskify/services/database_service.dart';
import 'package:taskify/utils/exports.dart';
import 'package:taskify/widgets/alert_toast.dart';

class AuthViewModel extends ChangeNotifier {
// Firebase Auth Service
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late DatabaseService _databaseService;

  AuthViewModel() {
    _authService = _getIt.get<AuthService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  // ! [ Login Section Data ]

  final loginTitle = "Login";
  final loginDesc = "Login to your account";

  bool isObscure = true;

  // Text Editing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      : val.length <= 7
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
  void submitLoginForm(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      setLoginLoading(true);

      final bool result = await _authService.login(
          emailController.text.trim(), passwordController.text.trim());

      if (result) {
        // user is available go to home
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);

        //  Clear the form
        emailController.clear();
        passwordController.clear();
      } else {
        showToast(
            message: "Invalid user credentials",
            context: context,
            icon: Icons.warning_rounded,
            iconColor: Colors.red);
      }

      setLoginLoading(false);
    }
  }

  // Sign Out
  logOutAccount(BuildContext context) async {
    final bool result = await _authService.logOut();
    if (result) {
      showToast(
          message: "Successfully logged out..!",
          context: context,
          icon: Icons.logout_rounded,
          iconColor: Colors.blue[700]);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } else {
      showToast(
          message: "Something went wrong..!",
          context: context,
          icon: Icons.warning_rounded,
          iconColor: Colors.red);
    }
    notifyListeners();
  }

  // ? Register Button
  void registerClick(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  // ! [ Register Section Data ]

  final registerTitle = "Register";
  final registerDesc = "Create your account";

  // Register loading state
  bool isRegLoad = false;

  // It changes the loading state
  setRegLoading(bool loading) async {
    isRegLoad = loading;
    notifyListeners();
  }

  // Text Editing Controllers
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  // Form Items
  final userName = FormItems(
    fieldName: "Name",
    hintText: "eg: Ravan",
    errorMsg: "Please enter your name",
  );
// Validation
  String? userNameValidation(String? val) =>
      val!.isEmpty ? userName.errorMsg : null;

// Register the user to fire store
  void userRegister(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      setRegLoading(true);

      final bool result = await _authService.signUp(
          regEmailController.text.trim(), regPasswordController.text.trim());

      if (result) {
        UserProfile userDetails = UserProfile(
          uid: _authService.user!.uid,
          name: userNameController.text.trim(),
        );
        await _databaseService.addUser(user: userDetails);

        // Success toast msg
        showToast(
            message: "Successfully registered..!",
            context: context,
            icon: Icons.done_rounded,
            iconColor: Colors.blue[700]);

        // After user register successfully back to login then go to home
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else {
        // Register failed toast msg
        showToast(
            message: "Failed to register..!",
            context: context,
            icon: Icons.warning_rounded,
            iconColor: Colors.red);
      }

      setRegLoading(false);
    }
  }
}
