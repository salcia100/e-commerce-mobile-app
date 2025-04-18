import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/api/product_api.dart';

import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class EditProductBody extends StatefulWidget {
  final int productId;
  final Product product;
  final Future<void> Function() onRefresh;

  const EditProductBody(
      {required this.productId,
      required this.product,
      required this.onRefresh,
      Key? key})
      : super(key: key);
  @override
  State<EditProductBody> createState() => _EditProductBodyState();
}

class _EditProductBodyState extends State<EditProductBody> {
  ProductApi productApi = new ProductApi();
  bool loading = false;

  formOnSubmit() async {
    Navigator.of(context).pop(); // Ferme la boîte
    setState(() => loading = true);
    try {
      await productApi.updateProduct(
          widget.productId, widget.product, _imageFile);
      successToast("Product updated successfully !");
      widget.onRefresh();
    } catch (e) {
      errorToast("Error while updating!");
    } finally {
      setState(() => loading = false);
    }
  }

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
                  : widget.product.image.isNotEmpty
                      ? Image.network(widget.product.image, height: 150)
                      : Container(
                          height: 150,
                          color: Colors.grey[200],
                          child:
                              Center(child: Text('Aucune image sélectionnée')),
                        ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nom du produit'),
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              initialValue: widget.product.name,
              onChanged: (textValue) {
                widget.product.name = textValue;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              initialValue: widget.product.description,
              onChanged: (textValue) {
                widget.product.description = textValue;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              initialValue: widget.product.price.toString(),
              onChanged: (textValue) {
                widget.product.price = double.tryParse(textValue) ?? 0;
                ;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              initialValue: widget.product.stock.toString(),
              onChanged: (textValue) {
                widget.product.stock = int.tryParse(textValue) ?? 0;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: loading ? null : formOnSubmit,
              icon: Icon(Icons.save, color: Colors.white),
              label: loading
                  ? Text("Mise à jour...",
                      style: TextStyle(color: Colors.white))
                  : Text("Mettre à jour",
                      style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: kIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
