import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/cart/cart_screen.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';
import 'package:inscri_ecommerce/screens/wishlist/wishlist_screen.dart';

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
            ? kIconColor // Highlight active icon
            : Colors.grey,
        size: 30,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index; // Change selected icon
        });

        // Define the destination screen based on the selected index
        Widget destination =
            HomeScreen(); // Default screen in case index is invalid;
        switch (index) {
          case 0:
            destination = HomeScreen(); // Replace with your actual screen
            break;
          case 1:
            destination = WishlistScreen();
            break;
          case 2:
            destination = CartScreen();
            break;
          case 3:
            //destination = PaletteScreen();
            break;
        }

        // Navigate to the selected page without replacing the current one
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
