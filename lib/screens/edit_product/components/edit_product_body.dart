import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:inscri_ecommerce/constant/theme_constants.dart';

class EditProductBody extends StatefulWidget {
  @override
  State<EditProductBody> createState() => _EditProductBodyState();
}

class _EditProductBodyState extends State<EditProductBody> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile != null
                  ? Image.file(File(_imageFile!.path), height: 150)
                  : Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: Center(child: Text('Aucune image sélectionnée')),
                    ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nom du produit'),
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
            ),
            SizedBox(height: 20),
            /*ElevatedButton.icon(
              onPressed: _updateProduct,
              icon: Icon(Icons.save),
              label: Text("Modifier le produit"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),*/
            SizedBox(height: 10),
            ElevatedButton(
              //ElevatedButton.icon(
              onPressed: () {
                // Action de suppression ici
                print("Élément supprimé !");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kIconColor, // Couleur rouge pour le bouton supprimer
              ),
              child: Text( "Supprimer",
                            style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
