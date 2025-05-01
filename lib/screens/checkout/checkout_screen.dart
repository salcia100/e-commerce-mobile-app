import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/checkout.dart';
import 'package:inscri_ecommerce/screens/checkout/components/agree_boutton.dart';
import 'components/shipping.dart';
import 'components/payment.dart';

class CheckoutScreen extends StatelessWidget {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CheckoutRequestModel requestModel = CheckoutRequestModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
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
            PaymentSection(),
            BottomSection(requestModel: requestModel,formKey:_formKey),
          ],
        ),
      ),
    );
  }
}
