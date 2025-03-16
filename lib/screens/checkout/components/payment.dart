import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'add_new_card.dart'; // Importez le composant AddNewCard

class PaymentSection extends StatefulWidget {
  @override
  _PaymentSectionState createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  bool _showAddNewCard = false; // État pour afficher ou masquer AddNewCard

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
          // Texte "or check out with"
          Center(
            child: Text(
              'or check out with',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          SizedBox(height: 15),
          // Icônes de paiement (PayPal, Visa, Mastercard) avec bordures arrondies
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPaymentIcon('assets/checkout/paypal_icon.jpg'),
              SizedBox(width: 10),
              _buildPaymentIcon('assets/checkout/visa_icon.jpg'),
              SizedBox(width: 10),
              _buildPaymentIcon('assets/checkout/banc_icon.jpg'),
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
            Color(0xFF005BAC), // Bleu officiel Visa
            Color(0xFF012169), // Bleu foncé Visa
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

  // Méthode pour afficher une icône de paiement avec bordures arrondies
  Widget _buildPaymentIcon(String iconPath) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Image.asset(
          iconPath,
          width: 30,
          height: 30,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
