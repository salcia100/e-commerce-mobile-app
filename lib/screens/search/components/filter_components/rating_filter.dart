import 'package:flutter/material.dart';

class RatingFilter extends StatefulWidget {
   final Function(int) onratingSelected;     

  RatingFilter({required this.onratingSelected});      
  @override
  _RatingFilterState createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  int selectedRating = 0; // Track the selected rating

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        int rating = index + 1;
        bool isSelected = selectedRating == rating;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedRating = rating;
            });
            widget.onratingSelected(selectedRating);        
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black, 
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: isSelected ? Colors.white : Colors.black,
                  size: 18,
                ),
                SizedBox(width: 1),
                Text(
                  rating.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
