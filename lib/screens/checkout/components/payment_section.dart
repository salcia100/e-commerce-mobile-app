import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'add_new_card.dart'; // Importez le composant AddNewCard

class PaymentSection extends StatefulWidget {
  final Function(String) onPaymentMethodSelected;

  PaymentSection({required this.onPaymentMethodSelected});
  @override
  _PaymentSectionState createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  bool _showAddNewCard = false; // État pour afficher ou masquer AddNewCard
  String selectedMethod = 'cash_on_delivery'; // default

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 2',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Payment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose your card',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showAddNewCard = !_showAddNewCard; // Basculer l'état
                  });
                },
                child: Text(
                  'Add new+',
                  style: TextStyle(
                    color: kIconColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          // Afficher AddNewCard si _showAddNewCard est true
          if (_showAddNewCard) AddNewCard(),

          // Liste horizontale de cartes Visa avec bordures arrondies
          if (!_showAddNewCard)
            Container(
              height: 160,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildVisaCard('1234'), // Numéro de carte simulé
                  SizedBox(width: 10),
                  _buildVisaCard('5678'), // Numéro de carte simulé
                  SizedBox(width: 10),
                  _buildVisaCard('9012'), // Numéro de carte simulé
                  SizedBox(width: 10),
                ],
              ),
            ),
          SizedBox(height: 20),
          // New Payment Method Buttons
          Center(
            child: Text(
              'Choose your payment method',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPaymentButton(
                  'Pay on Delivery', 'cash_on_delivery', Icons.delivery_dining),
              SizedBox(width: 20),
              _buildPaymentButton(
                  'Pay with Stripe', 'Stripe', Icons.credit_card),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisaCard(String cardNumber) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        //color: Color.fromARGB(255, 137, 159, 238),
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade800, // Bleu officiel Visa
            Colors.grey.shade100, // Bleu foncé Visa
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 226, 225, 225),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 226, 225, 225),
            ),
          ),
        ],
      ),
    );
  }

// Function to build the payment method buttons with better design
  Widget _buildPaymentButton(String label, String method, IconData icon) {
    final bool isSelected =
        selectedMethod == method; // Check if this method is selected
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method; // Update the selected method
        });
        widget.onPaymentMethodSelected(method); // notify parent
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade100 : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
