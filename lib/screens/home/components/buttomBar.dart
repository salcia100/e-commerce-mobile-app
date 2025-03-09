import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0; // Keeps track of the selected button

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 65,
      decoration: BoxDecoration(
        color: kbarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navIcon(0, Icons.home, Icons.home_outlined),
          navIcon(1, Icons.favorite, Icons.favorite_outline),
          navIcon(2, Icons.shopping_bag, Icons.shopping_bag_outlined),
          navIcon(3, Icons.palette, Icons.palette_outlined),
        ],
      ),
    );
  }

  Widget navIcon(int index, IconData filledIcon, IconData outlinedIcon) {
    return IconButton(
      icon: Icon(
        selectedIndex == index ? filledIcon : outlinedIcon,
        color: selectedIndex == index
            ? kIconColor   // Highlight active icon
            : Colors.grey, 
        size: 30,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index; // Change selected icon
        });
      },
    );
  }
}
