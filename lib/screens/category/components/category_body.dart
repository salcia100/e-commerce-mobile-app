import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/category_api.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/screens/category/components/sub_category_products.dart';

class CategoryBody extends StatefulWidget {
  final List<Category> mainCategories;
  const CategoryBody({Key? key, required this.mainCategories})
      : super(key: key);
  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  int selectedIndex = 0;
  List<Category> subCategories = [];
  final CategoryApi categoryApiService = CategoryApi();

  @override
  void initState() {
    super.initState();
    if (widget.mainCategories.isNotEmpty) {
      fetchsubCategories(widget.mainCategories[selectedIndex].id);
      print("Selected Category ID: ${widget.mainCategories[selectedIndex].id}");
    } else {
      print("Aucune catégorie principale trouvée !");
    }
  }

  @override
  void didUpdateWidget(covariant CategoryBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mainCategories.isNotEmpty && subCategories.isEmpty) {
      fetchsubCategories(widget.mainCategories[selectedIndex].id);
    }
  }

  void fetchsubCategories(id) async {
    try {
      List<Category> categorieData =
          await categoryApiService.getSubCategories(id);
      print("Sub Categories loaded: ${categorieData.length}");
      setState(() {
        subCategories = categorieData;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
        subCategories = [];
      });
    }
  }

  /*List<Map<String, String>> get currentPicks {
    String selectedCategory = categories[selectedIndex];
    return categoryPicks[selectedCategory] ?? [];
  }*/

  @override
  Widget build(BuildContext context) {
    if (widget.mainCategories.isEmpty) {
      return Scaffold(
        body: Center(child: Text("Aucune catégorie disponible.")),
      );
    }
    return Scaffold(
      body: Row(
        children: [
          // Left Category Menu (Main Categories)
          Container(
            width: MediaQuery.of(context).size.width * 0.27,
            color: Theme.of(context).cardColor,
            child: ListView.builder(
              itemCount: widget.mainCategories.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    fetchsubCategories(widget.mainCategories[index].id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    //color: isSelected ? Colors.white : Colors.grey.shade100,
                    color: isSelected
                     ? Theme.of(context).colorScheme.surface
                     : Theme.of(context).colorScheme.background,
                    child: Text(
                      widget.mainCategories[index].name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: Theme.of(context).textTheme.bodyMedium!.color,//color: isSelected ? Colors.black : Colors.grey.shade700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Right Picks Grid (Sub Categories)
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Picks for You",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  subCategories.isNotEmpty
                      ? GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 0.60,
                          children: subCategories.map((item) {
                            return InkWell(
                                onTap: () {
                                  print("Pressed on: ${item.name}");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SubCategoryProducts(
                                                  subCategory: item)));
                                },
                                child: Column(
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: item.image,
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      item.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ));
                          }).toList(),
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text("No items found for this category."),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
