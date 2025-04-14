import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/api/product_api.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class AddProductBody extends StatefulWidget {
  final Future<void> Function() ? onRefresh;
  const AddProductBody({required this.onRefresh});
  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  ProductApi productApi = new ProductApi();
  Map<String, String> formValues = {
    'name': "",
    'description': "",
    'price': "",
    'stock': "",
    'image': "",
  };
  bool loading = false;

  inputOnChanged(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (_image == null) {
      errorToast("Veuillez sélectionner une image !");
    } else if (formValues["name"]!.isEmpty) {
      errorToast("Product name Required!");
    } else if (formValues["description"]!.isEmpty) {
      errorToast("Product description Required");
    } else if (formValues["stock"]!.isEmpty) {
      errorToast("Product stock Required");
    } else if (formValues["price"]!.isEmpty) {
      errorToast("price Required");
    } else {
      setState(() {
        loading = true;
      });
      try {
        await productApi.addProduct(formValues, _image);
        successToast("Product added successfully!");
        Navigator.pop(context);
        widget.onRefresh!();
      } catch (e) {
        errorToast("Error while adding !");
      } finally {
        setState(() => loading = false);
      }
    }
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _selectedCategory; // Variable pour stocker la catégorie sélectionnée
  String? _selectedColor;
  String? _selectedSize;

  // Liste des catégories
  List<String> categories = ['Dress', 'Tops', 'Pants', 'Shoes', 'Accessories'];
  List<String> colors = [
    'Black',
    'White',
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Pink',
    'Purple'
  ];
  List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  Future<void> addImage() async {
    // Choix de l'image depuis la galerie (pour utiliser la caméra, change ImageSource.gallery en ImageSource.camera)
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
      print('Image sélectionnée : ${pickedImage.path}');
    } else {
      print('Aucune image sélectionnée.');
    }
  } // <-- Fermeture de la méthode addImage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Photos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _image != null
                      ? Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        )
                      : ImageBox(label: "Add photo here"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _image != null
                      ? Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        )
                      : ImageBox(label: "Add photo here"),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    addImage(); // Fonction pour ajouter une image
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
              decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Ex: Manteau noir, Robe effet satinée"),
              onChanged: (textValue) {
                inputOnChanged("name", textValue);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Description", hintText: "Décrivez votre produit"),
              maxLines: 3,
              onChanged: (textValue) {
                inputOnChanged("description", textValue);

                ///****** */
              },
            ),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: InputDecoration(labelText: 'Catégorie'),
              validator: (value) =>
                  value == null ? 'Sélectionnez une catégorie' : null,
            ),
            SizedBox(height: 10),

            /*DropdownButtonFormField(
              items: [],
              onChanged: (value) {},
              decoration: InputDecoration(labelText: "Category"),
            ),
            SizedBox(height: 10),*/
            Row(
              children: [
                //color
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedColor,
                    items: colors.map((color) {
                      return DropdownMenuItem<String>(
                        value: color,
                        child: Text(color),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedColor = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Color'),
                    validator: (value) => value == null ? 'Select Color' : null,
                  ),
                ),
                SizedBox(height: 10),

                //size
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSize,
                    items: sizes.map((size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Size'),
                    validator: (value) => value == null ? 'Select Size' : null,
                  ),
                ),

                SizedBox(height: 10),

                /*Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 2),
                    child: Text("color", style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 2),
                    child: Text("size", style: TextStyle(color: Colors.black)),
                  ),
                ),*/
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Price", hintText: "Ex: 29.900"),
                    onChanged: (textValue) {
                      inputOnChanged("price", textValue); //** */
                    },
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            //stock
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                        InputDecoration(labelText: "Stock", hintText: "20"),
                    onChanged: (textValue) {
                      inputOnChanged("stock", textValue); //** */
                    },
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            /* Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFDB3022)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration( hintText: "Veuillez mentionner si votre article a des défauts..."),
                
                style: TextStyle(color: Colors.black54),
              ),
            ),*/
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: formOnSubmit,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDB3022)),
                child: Text("Publish", style: TextStyle(color: Colors.white)),
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
