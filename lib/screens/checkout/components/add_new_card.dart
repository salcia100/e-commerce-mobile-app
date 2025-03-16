import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';

class AddNewCard extends StatefulWidget {
  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final _formKey = GlobalKey<FormState>();
  bool _isDefaultPaymentMethod = false; // État de la checkbox

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment methods',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your payment cards',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold, // Correction ici
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name on card',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name on the card';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Card number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the card number';
                }
                if (value.length != 16 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Please enter a valid 16-digit card number';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                      hintText: 'MM/YY',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the expiry date';
                      }
                      if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                        return 'Please enter a valid expiry date (MM/YY)';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                      hintText: '123',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the CVV';
                      }
                      if (value.length != 3 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid 3-digit CVV';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isDefaultPaymentMethod,
                  onChanged: (bool? value) {
                    setState(() {
                      _isDefaultPaymentMethod = value ?? false;
                    });
                    // Vous pouvez ajouter une logique supplémentaire ici
                    if (_isDefaultPaymentMethod) {
                      print('Default payment method set!');
                    } else {
                      print('Default payment method unset!');
                    }
                  },
                ),
                Text('Set as default payment method'),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si le formulaire est valide, afficher un message de succès
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Card Added Successfully')),
                    );

                    // Vous pouvez également enregistrer les données du formulaire ici
                    print('Card added: Default payment method: $_isDefaultPaymentMethod');
                  }
                },
                child: Text(
                  'ADD CARD',
                  style: TextStyle(color: Colors.white), 
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: kIconColor, // Fond du bouton en rouge
                  foregroundColor: Colors.white, // Texte en noir
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}