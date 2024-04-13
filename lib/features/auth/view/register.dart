import 'package:taskify/utils/exports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context).colorScheme;
    final authProvider = context.watch<AuthProvider>();
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
                            text: authProvider.registerTitle, context: context),
                        myTexts.med18dmSans(
                            text: authProvider.registerDesc,
                            context: context,
                            alterColor: theme.tertiary)
                      ],
                    ),
                  ),

                  // Login svg vector image
                  Expanded(
                      child: SvgPicture.asset(
                    registerVector,
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
                        fieldName: authProvider.userName.fieldName,
                        hintText: authProvider.userName.hintText,
                        validator: (val) =>
                            authProvider.userNameValidation(val),
                        controller: authProvider.userNameController),
                    gapH(20),
                    MyTextField(
                        fieldName: authProvider.email.fieldName,
                        hintText: authProvider.email.hintText,
                        validator: (val) => authProvider.emailValidation(val),
                        controller: authProvider.regEmailController),
                    gapH(20),
                    MyTextField(
                        obscure: authProvider.isObscure,
                        fieldName: authProvider.password.fieldName,
                        hintText: authProvider.password.hintText,
                        validator: (val) =>
                            authProvider.passwordValidation(val),
                        controller: authProvider.regPasswordController),
                  ],
                ),
              ),

              gapH(30),
              MyButton(
                onTap: () => authProvider.userRegister(context, formKey),
                title: authProvider.registerTitle,
              ),
              gapH(10),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: myTexts.med18dmSans(
                    textDecoration: TextDecoration.underline,
                    text: "Back",
                    context: context,
                    alterColor: theme.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
