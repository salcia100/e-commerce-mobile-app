/*import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //kelmet debug tetnaha
      home: Welcome(), // Afficher directement la page d'inscription
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/theme_controller.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeController.loadTheme(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Houni nesta3mlou ValueListenableBuilder bech n5allou MaterialApp yetsanna ay changement fil thème
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Thème light (par défaut)
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black87),
            ),
          ),
          // Thème dark
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            primaryColor: kIconColor,
            colorScheme: ColorScheme.dark(
    primary: Colors.white, 
    secondary: kIconColor, 
  ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white70),
            ),
          ),
          // Houni n7ottou l'état actuel mta3 thème (light wela dark)
          themeMode: currentTheme,
          home: Welcome(), 
        );
      },
    );
  }
}

