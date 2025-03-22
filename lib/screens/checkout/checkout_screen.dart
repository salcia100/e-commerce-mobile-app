import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/checkout.dart';
import 'package:inscri_ecommerce/screens/checkout/components/agree_boutton.dart';
import 'package:inscri_ecommerce/screens/checkout/components/total_price.dart';
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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Check out',
          style: TextStyle(
            color: Color(0xFF1D1F22),
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
            ProductPrice(),
            BottomSection(requestModel: requestModel,formKey:_formKey),
          ],
        ),
      ),
    );
  }
}
