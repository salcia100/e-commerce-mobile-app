import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/My_shop/components/product_card.dart';
import 'package:inscri_ecommerce/screens/add_product/add_product_screen.dart';
import 'package:inscri_ecommerce/screens/my_sales/my_sales_screen.dart';

class MyShopBody extends StatefulWidget {
  final List<Product> VendorProducts;
  final Future<void> Function() onRefresh;

  const MyShopBody(
      {Key? key, required this.VendorProducts, required this.onRefresh})
      : super(key: key);
  @override
  State<MyShopBody> createState() => _MyShopBodyState();
}

class _MyShopBodyState extends State<MyShopBody> {
  // Liste temporaire des produits
  final List<Map<String, dynamic>> staticproducts = [
    {
      "image": "assets/wishlist/1.jpg",
      "name": "robe1",
      "price": "40 DT",
      "likes": 12,
      "discount": 0,
      "created_at": "null"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Row with title and Add Product button and Orders button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,//color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProductScreen(
                                onRefresh: widget.onRefresh,
                              ),
                            ),
                          );
                          print("Add Product button pressed");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,//backgroundColor: Colors.white,
                          elevation: 0,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        child: Text(
                          'Add Product',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,//color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //orders 
                      const SizedBox(width: 8), // Space between buttons
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalesScreen(), // Navigate to orders screen of the vendor 
                            ),
                          );
                          print("Orders button pressed");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,//backgroundColor: Colors.white,
                          elevation: 0,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        child: Text(
                          'My sales',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,//color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            // GridView.builder wrapped in Expanded
            Expanded(
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.VendorProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: widget.VendorProducts[index],
                    onRefresh: widget.onRefresh,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
