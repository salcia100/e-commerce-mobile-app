/*import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/inscri.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}*/





import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/inscri.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //kelmet debug tetnaha
     /* title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),*/
      home: SignUpPage(), // Afficher directement la page d'inscription
    );
  }
}

