import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/api/category_api.dart';
import 'package:inscri_ecommerce/api/customOrder_api.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class CustomForm extends StatefulWidget {
  @override
  State<CustomForm> createState() => _CustomOrderFormState();
}

class _CustomOrderFormState extends State<CustomForm> {
  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  CustomOrdersApi customOrderApi = CustomOrdersApi();
  Map<String, dynamic> formValues = {
    'title': "",
    'description': "",
    'budget': "",
    'material': "",
    'image': "",
    'color': "",
    'category': "",
  };
  bool loading = false;

  inputOnChanged(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    formValues['category_id'] = selectedCategoryId.toString();
  if (_selectedColor != null && _selectedColor!.isNotEmpty) {
    formValues['color'] = _selectedColor!;
  }
  if (_selectedMaterial != null && _selectedMaterial!.isNotEmpty) {
    formValues['material'] = _selectedMaterial!;
  }
    if (_image == null) {
      errorToast("Veuillez sélectionner une image !");
    } else if (formValues["title"]!.isEmpty) {
      errorToast("Le titre de la commande est requis !");
    } else if (formValues["description"]!.isEmpty) {
      errorToast("La description de la commande est requise !");
    } else if (formValues["budget"]!.isEmpty) {
      errorToast("Le budget est requis !");
    } else if (double.tryParse(formValues["budget"]!) == null) {
      errorToast("Le budget doit être un nombre valide !");
    } else {
      setState(() {
        loading = true;
      });
      try {
        // Appel à l'API pour ajouter la commande personnalisée
        await customOrderApi.addCustomOrder(
          formValues['title'],
          formValues['description'],
          formValues['budget'],
          formValues['material'],
          formValues['color'],
          selectedCategoryId!,
          _image,
        );
        successToast("order added successfully !");
        Navigator.pop(context);
      } catch (e) {
        errorToast("Error adding order !");
      } finally {
        setState(() => loading = false);
      }
    }
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  int? _selectedCategory;
  int? selectedCategoryId;
  String? _selectedColor;
  String? _selectedMaterial;

  List<Category> mainCategories = [];
  final CategoryApi categoryApiService = CategoryApi();

  void fetchCategories() async {
    try {
      List<Category> categorieData = await categoryApiService.getCategories();
      setState(() {
        mainCategories = categorieData;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {});
    }
  }

  Future<void> addImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Photos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _image != null
                      ? Image.file(File(_image!.path), fit: BoxFit.cover, width: 100, height: 100)
                      : ImageBox(label: "Add photo here"),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    addImage();
                  },
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
            TextField(
              decoration: InputDecoration(labelText: "Title", hintText: "Add the name of your order"),
              onChanged: (textValue) {
                inputOnChanged("title", textValue);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Description", hintText: "Describe your order"),
              maxLines: 2,
              onChanged: (textValue) {
                inputOnChanged("description", textValue);
              },
            ),
            DropdownButtonFormField<int>(
              value: _selectedCategory,
              items: mainCategories.map((category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  selectedCategoryId = value;
                });
              },
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Material", hintText: "Material required"),
              onChanged: (textValue) {
                inputOnChanged("material", textValue);
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Color", hintText: "choose color"),
              onChanged: (textValue) {
                inputOnChanged("color", textValue);
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Budget", hintText: "Enter the budget"),
              keyboardType: TextInputType.number,
              onChanged: (textValue) {
                inputOnChanged("budget", textValue);
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: formOnSubmit,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFDB3022)),
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Submit Order", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final String label;
  ImageBox({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
