import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Définit la hauteur de l'AppBar
}

class _CustomAppBarState extends State<CustomAppBar> {
  int selectedIndex =
      0; // Gère l'index sélectionné (par exemple, pour gérer les icônes)

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kbarColor,
      leading: IconButton(
        icon: navIcon(2, Icons.person, Icons.person_outline),
        color: kIconColor,
        onPressed: () {},
      ),
      actions: [
        navIcon(0, Icons.search, Icons.search_outlined),
        navIcon(1, Icons.notifications, Icons.notifications_none_outlined),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }

  Widget navIcon(int index, IconData filledIcon, IconData outlinedIcon) {
    return IconButton(
      icon: Icon(
        selectedIndex == index ? filledIcon : outlinedIcon,
        color: selectedIndex == index
            ? kIconColor
            : Colors
                .grey, // Change la couleur en fonction de l'index sélectionné
        size: 30,
      ),
      onPressed: () {
        setState(() {
          selectedIndex =
              index; // Change l'index sélectionné et met à jour l'état
        });
      },
    );
  }
}
