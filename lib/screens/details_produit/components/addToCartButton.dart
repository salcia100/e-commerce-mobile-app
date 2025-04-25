import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inscri_ecommerce/screens/cart/cart_screen.dart';
import 'package:inscri_ecommerce/api/Cart_api.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/login.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';


class AddToCartButton extends StatefulWidget {
  final Product product;
  const AddToCartButton({Key? key, required this.product}) : super(key: key);
  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
                    String? token = await SecureStorage.getToken();
          if (token == null || token.isEmpty) {
            // Not logged in → redirect to login
            Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
            return;
          }
          // Logic for Add to Cart action
          int productID = widget.product.id;
          int quantity = 1; //widget.product.stock; //a modifier
          await CartApi.addProductToCart(productID, quantity);
          Navigator.push(
            //push add tocart---->page cart
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
          print("Add to Cart clicked!");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDB3022), // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Rounded corners
          ),

          fixedSize: Size(500, 50),
          padding: EdgeInsets.symmetric(
              horizontal: 50, vertical: 12), // Padding inside the button
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row
          children: [
            FaIcon(
              FontAwesomeIcons.cartPlus,
              color: Colors.white,
              size: 20, // Size of the icon
            ),
            SizedBox(width: 10), // Space between the icon and text
            Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
