import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/api/category_api.dart';
import 'package:inscri_ecommerce/api/customOrder_api.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class CustomForm extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const CustomForm({Key? key, required this.onRefresh}) : super(key: key);

  @override
  State<CustomForm> createState() => _CustomOrderFormState();
}

class _CustomOrderFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  XFile? _image;
  int? selectedCategoryId;
  String? _selectedColor;
  String? _selectedMaterial;

  bool loading = false;
  List<Category> mainCategories = [];

  final Map<String, String> formValues = {
    'title': '',
    'description': '',
    'budget': '',
    'quantity': '',
    'material': '',
    'color': '',
    'name': '',
    'phone': '',
    'shipping_address': '',
  };

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      final categories = await CategoryApi().getCategories();
      setState(() => mainCategories = categories);
    } catch (e) {
      errorToast("Failed to fetch categories");
    }
  }

  Future<void> addImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedImage != null) {
      setState(() => _image = pickedImage);
    }
  }

  void formOnSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_image == null) {
      errorToast("Please select an image!");
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() => loading = true);

      await CustomOrdersApi().addCustomOrder(
        formValues['title']!,
        formValues['description']!,
        formValues['budget']!,
        formValues['quantity']!,
        _selectedMaterial ?? '',
        _selectedColor ?? '',
        formValues['name']!,
        formValues['phone']!,
        formValues['shipping_address']!,
        selectedCategoryId!,
        _image,
      );

      successToast("Order added successfully!");
      widget.onRefresh?.call();
      Navigator.pop(context);
    } catch (e) {
      errorToast("Error adding order");
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Photos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _image != null
                        ? Image.file(File(_image!.path), width: 100, height: 100, fit: BoxFit.cover)
                        : ImageBox(label: "Add photo here"),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: addImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 30, color: Colors.grey),
                          Text("Add", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                validator: (val) => val == null || val.isEmpty ? "Title is required" : null,
                onSaved: (val) => formValues['title'] = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 2,
                validator: (val) => val == null || val.isEmpty ? "Description is required" : null,
                onSaved: (val) => formValues['description'] = val!,
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: "Category"),
                value: selectedCategoryId,
                items: mainCategories
                    .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                    .toList(),
                onChanged: (val) => setState(() => selectedCategoryId = val),
                validator: (val) => val == null ? "Category is required" : null,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Material"),
                      onSaved: (val) => _selectedMaterial = val,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Color"),
                      onSaved: (val) => _selectedColor = val,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                onSaved: (val) => formValues['quantity'] = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Budget"),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Budget is required";
                  if (double.tryParse(val) == null) return "Enter a valid number";
                  return null;
                },
                onSaved: (val) => formValues['budget'] = val!,
              ),

              SizedBox(height: 20),
              Text("Personal Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      validator: (val) => val == null || val.isEmpty ? "Name is required" : null,
                      onSaved: (val) => formValues['name'] = val!,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Phone"),
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Phone is required";
                        if (val.length != 8) return "Phone must be 8 digits";
                        return null;
                      },
                      onSaved: (val) => formValues['phone'] = val!,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Shipping Address"),
                validator: (val) => val == null || val.isEmpty ? "Address is required" : null,
                onSaved: (val) => formValues['shipping_address'] = val!,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: formOnSubmit,
                  style: ElevatedButton.styleFrom(backgroundColor: kIconColor),
                  child: loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Submit Order", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final String label;
  const ImageBox({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
