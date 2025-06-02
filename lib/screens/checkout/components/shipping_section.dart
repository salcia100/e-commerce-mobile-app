import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inscri_ecommerce/model/checkout.dart';

class ShippingSection extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final CheckoutRequestModel requestModel; // Ajout de requestModel

  ShippingSection({required this.formKey, required this.requestModel});
  @override
  State<ShippingSection> createState() => _ShippingSectionState();
}

class _ShippingSectionState extends State<ShippingSection> {
  late CheckoutRequestModel requestModel; 
  String name = '';
  String shipping_address = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Texte "Step 1" et "Shipping"
              Text(
                'Step 1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'Shipping',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Champs de saisie pour l'adresse de livraison
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name*',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name ' : null,
                onChanged: (value) {
                  setState(() => name = value);
                },
                onSaved: (value) {
                  widget.requestModel.name = value!;
                  print(
                      " Nom enregistré: ${widget.requestModel.name}"); // Debug
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                  decoration: InputDecoration(
                    labelText: 'shipping_address*',
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your shipping_address '
                      : null,
                  onChanged: (value) {
                    setState(() => shipping_address = value);
                  },
                  onSaved: (value) {
                    widget.requestModel.shipping_address = value!;
                    print(
                        " address enregistré: ${widget.requestModel.shipping_address}");
                  }),
              SizedBox(height: 10),
              TextFormField(
  decoration: InputDecoration(
    labelText: 'Phone*',
  ),
  keyboardType: TextInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(8),
  ],
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone';
    } else if (value.length != 8) {
      return 'Phone number must be 8 digits';
    }
    return null;
  },
  onChanged: (value) {
    setState(() => phone = value);
  },
  onSaved: (value) {
    widget.requestModel.phone = value!;
    print(" phone enregistré: ${widget.requestModel.phone}");
  },
)
            ],
          ),
        ));
  }
}
