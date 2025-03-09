import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddToCartButton extends StatefulWidget {
  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Logic for Add to Cart action
          print("Add to Cart clicked!");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Button color
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
