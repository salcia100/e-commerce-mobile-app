import 'package:flutter/material.dart';

class ColorFilter extends StatefulWidget {
  final Function(List<String>) onColorSelected; 

  ColorFilter({required this.onColorSelected}); 
  @override
  _ColorFilterState createState() => _ColorFilterState();
}

class _ColorFilterState extends State<ColorFilter> {
  // List of available colors
  final List<Map<String, dynamic>> colors = [
   
    {'name': 'Red', 'color': Colors.red},
    {'name': 'green', 'color': Colors.green},
    {'name': 'blue', 'color': Colors.blue},
    {'name': 'yellow', 'color': Colors.yellow},
    {'name': 'White', 'color': Colors.white},
    {'name': 'purple', 'color': Colors.purple},
    {'name': 'black', 'color': Colors.black},
    {'name': 'Brown', 'color': Colors.brown},
    {'name': 'orange', 'color': Colors.orange},
    {'name': 'Pink', 'color': Colors.pink},
    {'name': 'grey', 'color': Colors.grey},
    {'name': 'cyan', 'color': Colors.cyan},
  ];
  // Track selected colors
  List<String> selectedColors = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colors.map((color) {
        String colorName = color['name'];
        bool isSelected = selectedColors.contains(colorName);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedColors.remove(colorName); // désélectionner
              } else {
                selectedColors.add(colorName); // sélectionner
              }
            });

            widget.onColorSelected(selectedColors);
          },
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: color['color'], 
              shape: BoxShape.circle,
              border:
                  isSelected ? Border.all(color: Colors.black, width: 2) : null,
            ),
            child: isSelected
                ? Icon(Icons.check,
                    size: 10, color: Color.fromARGB(255, 147, 43, 59))
                : null,
          ),
        );
      }).toList(),
    );
  }
}
