import 'package:taskify/utils/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Taski",
              style: GoogleFonts.dmSans(
                  color: theme.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 42)),
          TextSpan(
              text: "fy",
              style: GoogleFonts.dmSans(
                  color: theme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 42))
        ])),
      ),
    );
  }
}
