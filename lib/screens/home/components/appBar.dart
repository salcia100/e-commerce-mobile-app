import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';

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
        onPressed: widget.onProfilePressed, // Ouvre le sidebar
      ),
      actions: [
        navIcon(1, Icons.search, Icons.search_outlined),
        navIcon(2, Icons.notifications, Icons.notifications_none_outlined),
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
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onProfilePressed; // Callback passed from HomeScreen

  CustomAppBar({required this.onProfilePressed});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Height of the appBar
}

class _CustomAppBarState extends State<CustomAppBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kbarColor,
      leading: IconButton(
        icon: navIcon(2, Icons.person, Icons.person_outline),
        color: kIconColor,
        onPressed: widget
            .onProfilePressed, // This triggers the onProfilePressed callback
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
        color: selectedIndex == index ? kIconColor : Colors.grey,
        size: 30,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
*/