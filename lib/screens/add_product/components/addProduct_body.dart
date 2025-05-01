import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/api/category_api.dart';
import 'package:inscri_ecommerce/api/product_api.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/utils/toast.dart';
import 'package:collection/collection.dart';

class AddProductBody extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const AddProductBody({required this.onRefresh});
  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  ProductApi productApi = new ProductApi();
  Map<String, dynamic> formValues = {
    'name': "",
    'description': "",
    'price': "",
    'stock': "",
    'image': "",
    'color': "",
    'size': "",
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
    if (_selectedSize != null && _selectedSize!.isNotEmpty) {
      formValues['size'] = _selectedSize!;
    }
    if (_image == null) {
      errorToast("Veuillez sélectionner une image !");
    } else if (formValues["name"]!.isEmpty) {
      errorToast("Product name Required!");
    } else if (formValues["description"]!.isEmpty) {
      errorToast("Product description Required");
    } else if (formValues["stock"]!.isEmpty) {
      errorToast("Product stock Required");
    } else if (int.tryParse(formValues["stock"]!) == null) {
      errorToast("Stock must be an integer");
    } else if (formValues["price"]!.isEmpty) {
      errorToast("Price Required");
    } else if (double.tryParse(formValues["price"]!) == null) {
      errorToast("Price must be a number");
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
  int? _selectedCategory; // Variable pour stocker la catégorie sélectionnée
  int? selectedCategoryId; // Will hold the final selected category ID
  int?
      _selectedSubCategory; // Variable pour stocker la sous-catégorie sélectionnée
  String? _selectedColor;
  String? _selectedSize;

  List<Category> mainCategories = [];
  List<Category> subCategories = [];
  final CategoryApi categoryApiService = CategoryApi();

  void fetchCategories() async {
    try {
      List<Category> categorieData = await categoryApiService.getCategories();
      print("Categories loaded: ${categorieData.length}");
      setState(() {
        mainCategories = categorieData;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {});
    }
  }

  void fetchSubCategories(int id) async {
    try {
      List<Category> subCategorieData =
          await categoryApiService.getSubCategories(id);
      print("Categories loaded: ${subCategorieData.length}");
      setState(() {
        subCategories = subCategorieData;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {});
    }
  }

  List<String> colors = [
    'Black',
    'White',
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Pink',
    'Purple',
    'Brown',
    'Orange'
  ];
  List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  Future<void> addImage() async {
    // Choix de l'image depuis la galerie
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
  } 

  bool isSizeVisible() {
    final allCategories = [...mainCategories, ...subCategories];
    final selectedCategory = allCategories.firstWhereOrNull(
      (category) => category.id == selectedCategoryId,
    );
    if (selectedCategory == null) return false;
    return !(selectedCategory.id == 5 ||
        selectedCategory.id == 6 ||
        selectedCategory.parentId == 5 ||
        selectedCategory.parentId == 6);
  }

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
              maxLines: 2,
              onChanged: (textValue) {
                inputOnChanged("description", textValue);
              },
            ),
            //category
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
                  selectedCategoryId = value; // Set default to main category
                  _selectedSubCategory = null;
                  fetchSubCategories(value!); // fetch its subcategories
                });
              },
              decoration: InputDecoration(labelText: 'Catégorie principale'),
            ),
            SizedBox(height: 10),
            //subcategory
            if (subCategories.isNotEmpty)
              DropdownButtonFormField<int>(
                value: _selectedSubCategory,
                items: subCategories.map((subCat) {
                  return DropdownMenuItem<int>(
                    value: subCat.id,
                    child: Text(subCat.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubCategory = value;
                    selectedCategoryId = _selectedSubCategory;
                  });
                },
                decoration: InputDecoration(labelText: 'Sous-catégorie'),
              ),

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
                if (isSizeVisible())
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
                    ),
                  ),

                SizedBox(height: 10),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Price", hintText: "Ex: 29.900"),
                        keyboardType: TextInputType.number,
                    onChanged: (textValue) {
                      inputOnChanged("price", textValue);
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
                        keyboardType: TextInputType.number,
                    onChanged: (textValue) {
                      inputOnChanged("stock", textValue); //** */
                    },
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),

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
