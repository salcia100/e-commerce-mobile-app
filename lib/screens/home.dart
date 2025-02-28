import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/components/body.dart';
import 'components/buttomBar.dart';
import 'components/appBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Body(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
