import 'package:flutter/material.dart';

class CategoryBody extends StatefulWidget {
  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  final List<String> categories = [
    "All",
    "Dresses",
    "Tops",
    "Pants",
    "Jump-suits",
    "Accessories",
    "Beauty",
    "Sweaters",
    "Outerwear",
    "shoes",
    "Weddings & Events",
    "Sports",
  ];

  int selectedIndex = 0;

  final Map<String, List<Map<String, String>>> categoryPicks = {
    "Dresses": [
      {"image": "assets/categories/wedding dress.jpg", "label": "Wedding\nDresses"},
      {"image": "assets/categories/Bridesmaid_Dresses.jpg", "label": "Bridesmaid\nDresses"},
      {"image": "assets/categories/Maxi Dress.jpg", "label": "Maxi Dress"},
      {"image": "assets/categories/Midi Dress.jpg", "label": "Midi Dress"},
      {"image": "assets/categories/Mini Dress.jpg", "label": "Mini Dress"},
      {"image": "assets/categories/Empire Waist_Dress.jpg", "label": "Empire Waist\nDress"},
      {"image": "assets/categories/Sheath Dress.jpg", "label": "Sheath Dress"},
      {"image": "assets/categories/wrap dress.jpg", "label": "Wrap Dress"},
      {"image": "assets/categories/sundress.jpg", "label": "Sundress"},
      {"image": "assets/categories/Tulle Dress.jpg", "label": "Tulle Dress"},
      {"image": "assets/categories/Women Formal_Evening Dresses.jpg", "label": "Women Formal\n& Evening Dresses"},
      {"image": "assets/categories/casual dress.jpg", "label": "Casual Dresses"},
    ],
  };

  List<Map<String, String>> get currentPicks {
    String selectedCategory = categories[selectedIndex];
    return categoryPicks[selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Category Menu
          Container(
            width: MediaQuery.of(context).size.width * 0.27,
            color: Colors.grey.shade100,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: isSelected ? Colors.white : Colors.grey.shade100,
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.grey.shade700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Right Picks Grid
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
                  currentPicks.isNotEmpty
                      ? GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 0.60,
                          children: currentPicks.map((item) {
                            return Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    item["image"]!,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  item["label"]!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            );
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