import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/login.dart';
import 'package:inscri_ecommerce/screens/search/search_screen.dart';
import 'package:inscri_ecommerce/screens/wishlist/wishlist_screen.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onProfilePressed;

  CustomAppBar({required this.onProfilePressed});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kbarColor,
      leading: IconButton(
        icon: Icon(Icons.person_outline, color: Colors.grey, size: 30),
        onPressed: () async {
          String? token = await SecureStorage.getToken();
            if (token == null || token.isEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Login()),
              );
              return;
          } else {
            widget.onProfilePressed();
          }
        },
      ),
      actions: [
        navIcon(1, Icons.search, Icons.search_outlined),
        navIcon(2, Icons.favorite, Icons.favorite_outline),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }

  Widget navIcon(int index, IconData filledIcon, IconData outlinedIcon) {
    return IconButton(
      icon: Icon(
        selectedIndex == index ? filledIcon : outlinedIcon,
        color: selectedIndex == index ? kIconColor : Colors.grey,
        size: 30,
      ),
      onPressed: () async{
        setState(() {
          selectedIndex = index;
        });
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        } else if (index == 2) {
                    String? token = await SecureStorage.getToken();
            if (token == null || token.isEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Login()),
              );
              return;
            }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistScreen()),
          );}
        }
      },
    );
  }
}

