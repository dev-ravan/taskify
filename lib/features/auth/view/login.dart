import 'package:taskify/utils/exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context).colorScheme;
    final authProvider = context.watch<AuthProvider>();
    authProvider.emailController.text = "ravan@gmail.com";
    authProvider.passwordController.text = "ravan@123";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH(heightMQ(context) / 6.5),
              // Login title and vector image
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Login title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myTexts.med32dmSans(
                            text: authProvider.loginTitle, context: context),
                        myTexts.med18dmSans(
                            text: authProvider.loginDesc,
                            context: context,
                            alterColor: theme.tertiary)
                      ],
                    ),
                  ),

                  // Login svg vector image
                  Expanded(
                      child: SvgPicture.asset(
                    loginVector,
                    fit: BoxFit.fitHeight,
                    width: widthMQ(context) / 3,
                  ))
                ],
              ),
              gapH(20),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                        fieldName: authProvider.email.fieldName,
                        hintText: authProvider.email.hintText,
                        validator: (val) => authProvider.emailValidation(val),
                        controller: authProvider.emailController),
                    gapH(20),
                    MyTextField(
                        obscure: authProvider.isObscure,
                        fieldName: authProvider.password.fieldName,
                        hintText: authProvider.password.hintText,
                        validator: (val) =>
                            authProvider.passwordValidation(val),
                        controller: authProvider.passwordController),
                  ],
                ),
              ),

              gapH(20),
              MyButton(
                onTap: () => authProvider.submitLoginForm(context, formKey),
                title: authProvider.loginTitle,
              ),
              gapH(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myTexts.med18dmSans(
                      text: "Don't have account?",
                      context: context,
                      alterColor: theme.tertiary),
                  gap4,
                  InkWell(
                    onTap: () => authProvider.registerClick(context),
                    child: myTexts.med18dmSans(
                      text: "Register",
                      context: context,
                      alterColor: theme.primary,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
