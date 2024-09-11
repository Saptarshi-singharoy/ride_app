import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_app/src/screens/login_screen.dart';

ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 255, 203, 203),
        primary: Colors.red),
    textTheme: GoogleFonts.poppinsTextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Colors.black54,
        unselectedLabelStyle: TextStyle(color: Colors.black54)));

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: LoginScreen()
        // BottomTab(),
        );
  }
}
