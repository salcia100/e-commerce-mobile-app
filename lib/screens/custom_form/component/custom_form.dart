import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  XFile? _pickedImage;
  final picker = ImagePicker();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _budget = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _quantity = TextEditingController();

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(),
                  ),
                  child: _pickedImage == null
                      ? const Center(child: Text("add image"))
                      : Image.file(
                          File(_pickedImage!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextFormField(
                controller: _description,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              TextFormField(
                controller: _budget,
                decoration: const InputDecoration(labelText: "Budget"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _category,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              TextFormField(
                controller: _quantity,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Action de soumission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("order submitted !")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kIconColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
