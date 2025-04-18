import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/add_product/add_product_screen.dart';
import 'package:inscri_ecommerce/screens/cart/cart_screen.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';
import 'package:inscri_ecommerce/screens/wishlist/wishlist_screen.dart';

class BottomBar extends StatefulWidget {
  final Future<void> Function()? onRefresh; // Nullable onRefresh function
  final int initialIndex;
  const BottomBar({Key? key, this.onRefresh, this.initialIndex = 0})
      : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int selectedIndex; // Keeps track of the selected button

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex; // use passed value
  }

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
          navIcon(2, Icons.add_a_photo, Icons.add_a_photo_outlined),
          navIcon(3, Icons.shopping_bag, Icons.shopping_bag_outlined),
          navIcon(4, Icons.palette, Icons.palette_outlined),
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
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    HomeScreen(), // ← Let HomeScreen handle the Scaffold + BottomBar
              ),
              (route) => false,
            );
            return;
          }

          setState(() {
            selectedIndex = index;
          });

          Widget destination;
          switch (index) {
            case 1:
              destination = WishlistScreen();
              break;
            case 2:
              destination = AddProductScreen(onRefresh: widget.onRefresh);
              break;
            case 3:
              destination = CartScreen();
              break;
            default:
              return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: destination,
                bottomNavigationBar: BottomBar(
                  onRefresh: widget.onRefresh,
                  initialIndex: index,
                ),
              ),
            ),
          );
        });
  }
}
