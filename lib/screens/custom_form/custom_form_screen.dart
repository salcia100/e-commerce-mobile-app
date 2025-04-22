import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/custom_form/component/custom_form.dart';
import 'package:inscri_ecommerce/screens/custom_form/component/form_appBar.dart';


class FormScreen extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const FormScreen({required this.onRefresh});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(),
      body: CustomForm(),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
