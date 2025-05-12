import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/checkout_api.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/checkout/CheckoutWebView.dart';
import 'package:inscri_ecommerce/model/checkout.dart';
import 'package:inscri_ecommerce/screens/checkout/checkout_accepted.dart';
// Import de la page CheckoutAccepted

class BottomSection extends StatefulWidget {
  final CheckoutRequestModel requestModel;
  final GlobalKey<FormState> formKey; // Utilise la clé du formulaire du parent

  BottomSection({required this.requestModel, required this.formKey});

  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  bool _isChecked = false; // État de la case à cocher

  bool validateAndSave() {
    //******************
    final form = widget.formKey.currentState;
    if (form?.validate() ?? false) {
      form?.save();
      print("Données après save: ${widget.requestModel.toJson()}"); // Debug
      return true;
    }
    print("❌ Form non valide");
    return false;
  }

  void _placeOrder() async {
    if (_isChecked && validateAndSave()) {
      CheckoutApi api = CheckoutApi();

      var result = await api.checkout(widget.requestModel);

      if (result != null) {
        // L'URL de paiement Stripe a été récupérée avec succès
        print('URL de paiement Stripe: $result');

        if (widget.requestModel.paymentMethod == "cash_on_delivery") {
          // Redirection vers la page de succès si c'est un paiement à la livraison
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutAccepted(), // ta page de succès
            ),
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutWebView(paymentUrl: result),
              ));
        }
      } else {
        print("Veuillez remplir le formulaire et accepter les conditions !");
      }
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
                  color: Theme.of(context).dividerColor,
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
              child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Ajuste la taille pour éviter un espace inutile
                  children: [
                ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kIconColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    disabledBackgroundColor:
                        Colors.grey, // Couleur grisée si désactivé
                  ),
                  child: Text(
                    'Place my order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
