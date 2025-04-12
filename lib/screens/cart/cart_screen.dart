import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Cart_api.dart';
import 'package:inscri_ecommerce/model/Cart.dart';
import 'package:inscri_ecommerce/screens/cart/components/appBar_cart.dart';
import 'package:inscri_ecommerce/screens/cart/components/cart_item.dart';
import 'package:inscri_ecommerce/screens/cart/components/cart_resume.dart';
import 'package:inscri_ecommerce/screens/checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartApi apiService = CartApi();
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      List<dynamic> data = await apiService.GetCart();
      print("Products loaded: ${data.length}");
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Added method to handle pull-to-refresh
  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchProducts();
  }

  // Method to remove item from the list
  void removeItem(int id) {
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
  }

  //Methode to update item quantity
   void updateQuantity(int id, int newQuantity) {
    setState(() {
      for (var product in products) {
        if (product.id == id) {
          product.quantity = newQuantity;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh, // Trigger _onRefresh when pulled
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Cart item = products[index];
                  return CartItem(
                    cart: Cart(
                        id: item.id,
                        title: item.title,
                        size: "s",
                        color: "red",
                        price: item.price,
                        quantity: item.quantity,
                        imagePath: item.imagePath),
                    removeItem: removeItem, // Pass removeItem callback
                    updateQuantity: updateQuantity, // Pass update function
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Résumé du panier
          //const CartSummary(subtotal: 110.00),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDB3022),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () {
              // Logic for Add to Cart action

              Navigator.push(
                //push add tocart---->page checkout
                context,
                MaterialPageRoute(builder: (context) => CheckoutScreen()),
              );
            },
            child: const Text(
              'Proceed to checkout',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
