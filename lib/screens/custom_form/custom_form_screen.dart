import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/custom_form/component/custom_form.dart';
import 'package:inscri_ecommerce/screens/custom_form/component/form_appBar.dart';


class CustomFormScreen extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const CustomFormScreen({required this.onRefresh});

  @override
  State<CustomFormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<CustomFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(),
      body: CustomForm(onRefresh: widget.onRefresh),
      //bottomNavigationBar: BottomAppBar(),
    );
  }
}
