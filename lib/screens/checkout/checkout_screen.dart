import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/checkout/components/agree_boutton.dart';
import 'package:inscri_ecommerce/screens/checkout/components/total_price.dart';
import 'components/shipping.dart';
import 'components/payment.dart';


class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShippingSection(),
            PaymentSection(),
            ProductPrice(),
            BottomSection(),
          ],
        ),
      ),
    );
  }
}