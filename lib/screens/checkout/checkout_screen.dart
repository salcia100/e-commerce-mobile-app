import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/checkout.dart';
import 'package:inscri_ecommerce/screens/checkout/components/bottom_section.dart';
import 'components/shipping_section.dart';
import 'components/payment_section.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedMethod = 'cash_on_delivery';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CheckoutRequestModel requestModel = CheckoutRequestModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Check out',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontSize: 18,
            fontFamily: 'Product Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShippingSection(formKey: _formKey, requestModel: requestModel),
            PaymentSection(
              onPaymentMethodSelected: (method) {
                selectedMethod = method;
                requestModel.paymentMethod = method;
              },
            ),
            BottomSection(requestModel: requestModel, formKey: _formKey),
          ],
        ),
      ),
    );
  }
}
