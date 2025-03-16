import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/checkout/checkout_accepted.dart';
// Import de la page CheckoutAccepted

class BottomSection extends StatefulWidget {
  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  bool _isChecked = false; // État de la case à cocher

  void _placeOrder() {
    if (_isChecked) {
      // Naviguer vers la page CheckoutAccepted 🎉
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckoutAccepted()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section "Agree to Terms and Conditions"
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
                activeColor: kIconColor,
              ),
              Text(
                'I agree to Terms and Conditions',
                style: TextStyle(
                  color: Color.fromRGBO(29, 31, 34, 1),
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Bouton "Place my order"
          Center(
            child: ElevatedButton(
              onPressed: _isChecked ? _placeOrder : null, // Désactivé si la case n'est pas cochée
              style: ElevatedButton.styleFrom(
                backgroundColor: kIconColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                disabledBackgroundColor: Colors.grey, // Couleur grisée si désactivé
              ),
              child: Text(
                'Place my order',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
