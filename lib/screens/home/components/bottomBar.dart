import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/add_product/add_product_screen.dart';
import 'package:inscri_ecommerce/screens/cart/cart_screen.dart';
import 'package:inscri_ecommerce/screens/category/category_screen.dart';
import 'package:inscri_ecommerce/screens/customised_orders/custom_order_screen.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';
import 'package:inscri_ecommerce/screens/login.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class BottomBar extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  final int initialIndex;

  const BottomBar({ this.onRefresh, this.initialIndex = 0});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 65,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, 
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navIcon(0, Icons.home, Icons.home_outlined, "Home"),
          navIcon(1, Icons.dashboard, Icons.dashboard_outlined, "Category"),
          navIcon(2, Icons.add_a_photo, Icons.add_a_photo_outlined, "  Add  "),
          navIcon(3, Icons.shopping_bag, Icons.shopping_bag_outlined, "  Cart  "),
          navIcon(4, Icons.palette, Icons.palette_outlined, " Custom"),
        ],
      ),
    );
  }

  Widget navIcon(int index, IconData filledIcon, IconData outlinedIcon, String label) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () async {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
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
            destination = CategoryScreen(onRefresh: widget.onRefresh);
            break;
          case 2:
            String? token = await SecureStorage.getToken();
            if (token == null || token.isEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
              return;
            } else {
              destination = AddProductScreen(onRefresh: widget.onRefresh);
            }
            break;
          case 3:
            String? token = await SecureStorage.getToken();
            if (token == null || token.isEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
              return;
            } else {
              destination = const CartScreen();
            }
            break;
          case 4:
            String? token = await SecureStorage.getToken();
            if (token == null || token.isEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
              return;
            } else {
              destination = CustomOrderScreen(onRefresh: widget.onRefresh);
            }
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
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? filledIcon : outlinedIcon,
            color: isSelected ? kIconColor : Theme.of(context).iconTheme.color,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? kIconColor : Theme.of(context).iconTheme.color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
