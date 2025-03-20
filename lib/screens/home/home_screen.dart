import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/home/components/body.dart';
import 'package:inscri_ecommerce/screens/profile_sidebar.dart';
import 'components/buttomBar.dart';
import 'components/appBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 255, 252, 252),
      appBar: CustomAppBar(onProfilePressed: () {
        _scaffoldKey.currentState?.openDrawer(); // Ouvre le sidebar
      }),
      drawer: ProfileSidebar(),
      body: Body(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
