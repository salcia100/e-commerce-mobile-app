import 'package:flutter/material.dart';

class ColorFilter extends StatefulWidget {
  @override
  _ColorFilterState createState() => _ColorFilterState();
}

class _ColorFilterState extends State<ColorFilter> {
  // List of available colors
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.black,
    Colors.brown,
  ];
  // Track selected colors
  List<Color> selectedColors = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colors.map((color) {
        bool isSelected = selectedColors.contains(color);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedColors.remove(color); // unselect
              } else {
                selectedColors.add(color); // select
              }
            });
          },
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: color,
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
