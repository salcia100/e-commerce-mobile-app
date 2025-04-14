import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/search/components/appBar.dart';
import 'package:inscri_ecommerce/screens/search/components/search_body.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_sidebar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Cette fonction sera passée à FilterSidebar
  late Function(List<Product>) onFilteredResultsCallback;

  final _searchBodyKey = GlobalKey<BodyState>(); // 👈 clé pour accéder à l’état interne
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SearchAppBar(),
      body:SearchBody(
        key: _searchBodyKey, // 👈 on donne la clé ici
        onfilterPressed: () {
        _scaffoldKey.currentState?.openEndDrawer(); // Ouvre le sidebar
      },
      onFilteredResults: (results) {
          _searchBodyKey.currentState?.onFilteredResults(results); // Appelle la méthode dans _BodyState
        },),
      endDrawer: FilterSidebar(onFilteredResults: (results) {
          _searchBodyKey.currentState?.onFilteredResults(results);
        },),
    );
  }
}
