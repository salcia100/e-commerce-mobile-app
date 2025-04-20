import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/checkout/checkout_screen.dart';

class CartResume extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, -1),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
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
