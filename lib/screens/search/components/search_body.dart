import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/product_api.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/details_produit/details_screen.dart';
import 'package:inscri_ecommerce/screens/home/components/item_card.dart';

class SearchBody extends StatefulWidget {
  final VoidCallback onfilterPressed;
  final Function(List<Product>) onFilteredResults; 
  SearchBody({Key? key, required this.onfilterPressed,required this.onFilteredResults,}) : super(key: key);

  @override
  State<SearchBody> createState() => BodyState();
}

class BodyState extends State<SearchBody> {
  ProductApi productApi = new ProductApi();
  List<dynamic> _products = []; // List to store search results
  List<String> _searchHistory = [];
  

  void searchProduct(String query) async {
    List<dynamic> results = await productApi.searchProducts(query);
    setState(() {
      _products = results;
      _updateSearchHistory(query);
    });
  }

  void _updateSearchHistory(String query) {
    setState(() {
      _searchHistory.remove(query); // Avoid duplicates
      _searchHistory.insert(0, query); // Add new query to top
      if (_searchHistory.length > 3) {
        _searchHistory.removeLast(); // Keep only last 3 searches
      }
    });
  }
  
void onFilteredResults(List<Product> results) {
  setState(() {
    _products = results;
  });
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  height: 49,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: Color(0xFF777E90),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onChanged:
                              searchProduct, // Fetch products dynamically
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.search, color: Color(0xFF777E90)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10), // Space between the containers
              // Second Container: Filter Button
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    widget.onfilterPressed(); // Ouvre le sidebar
                  },
                  child: Container(
                    height: 49,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(Icons.tune, color: Color(0xFF777E90)),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Dynamic Recent Searches
        if (_searchHistory.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: _searchHistory
                  .map((word) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(word),
                          deleteIcon: Icon(Icons.cancel, size: 18),
                          onDeleted: () {
                            setState(() {
                              _searchHistory.remove(word);
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),

        
        // Display Products Below Search Bar
        Expanded(
          child: _products.isEmpty
              ? Center(child: Text("Aucun produit trouvé..."))
              : GridView.builder(
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPadding,
                    crossAxisSpacing: kDefaultPadding,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                        product: _products[index],
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  product: _products[index],
                                ),
                              ));
                        },
                      )),
        ),
      ],
    );
  }
}
