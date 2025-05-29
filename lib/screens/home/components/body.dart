import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/screens/details_produit/details_screen.dart';
import 'package:inscri_ecommerce/screens/login.dart';
import 'package:inscri_ecommerce/screens/signup.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';
import 'categories.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final List<dynamic> products;
  final List<Category> categories;
  final Function(int) onCategorySelected; // callback

  Body(
      {required this.onRefresh,
      required this.products,
      required this.categories,
      required this.onCategorySelected});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    String? token = await SecureStorage.getToken();
    setState(() {
      isLoggedIn = token != null && token.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Women",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).iconTheme.color,
                      letterSpacing: 1.5,
                    ),
              ),
              if (!isLoggedIn)
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()))
                            .then((_) => checkLoginStatus());
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kIconColor,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()))
                            .then((_) => checkLoginStatus());
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Categories(
          categories: widget.categories,
          onCategorySelected: widget.onCategorySelected,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: GridView.builder(
              itemCount: widget.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) => ItemCard(
                product: widget.products[index],
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        onRefresh: widget.onRefresh,
                        product: widget.products[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
