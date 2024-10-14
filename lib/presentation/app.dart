import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_app/presentation/auth/screens/login_screen.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red[900]!,
      primary: Colors.red[900],
      secondary: Colors.black,
      tertiary: Colors.grey[50]),
  textTheme: GoogleFonts.poppinsTextTheme(),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, theme: theme, home: LoginScreen());
  }
}
