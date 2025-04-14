import 'package:flutter/material.dart';

class DiscountFilter extends StatefulWidget {
  final Function(List<String>) ondiscountSelected; //######1

  DiscountFilter({required this.ondiscountSelected}); //######2
  @override
  _DiscountFilterState createState() => _DiscountFilterState();
}

class _DiscountFilterState extends State<DiscountFilter> {
  List<String> discounts = ['10%', '20%', '30%', '50%'];
  List<String> selectedDiscounts = []; //######3

  bool showOnlyDiscounted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          children: discounts.map((discount) {
            bool isSelected = selectedDiscounts.contains(discount);

            return ChoiceChip(
              label: Text(
                "$discount OFF",
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selected: isSelected,
              selectedColor: Colors.black,
              backgroundColor: Colors.grey[200],

              onSelected: (selected) {
                 setState(() {
                  if (isSelected) {
                    selectedDiscounts.remove(discount);
                  } else {
                    selectedDiscounts.add(discount);
                  }

                  // Notifie le parent
                  widget.ondiscountSelected(selectedDiscounts);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
