import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/search/components/appBar.dart';
import 'package:inscri_ecommerce/screens/search/components/body.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_sidebar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SearchAppBar(),
      body:SearchBody(onfilterPressed: () {
        _scaffoldKey.currentState?.openEndDrawer(); // Ouvre le sidebar
      }),
      endDrawer: FilterSidebar(),
    );
  }
}
