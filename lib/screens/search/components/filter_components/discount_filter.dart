import 'package:flutter/material.dart';

class DiscountFilter extends StatefulWidget {
  @override
  _DiscountFilterState createState() => _DiscountFilterState();
}

class _DiscountFilterState extends State<DiscountFilter> {
  List<String> discounts = ['10%', '20%', '30%', '50%'];
  String? selectedDiscount;

  bool showOnlyDiscounted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          children: discounts.map((discount) {
            bool isSelected = selectedDiscount == discount;

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
                  selectedDiscount = selected ? discount : null;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
