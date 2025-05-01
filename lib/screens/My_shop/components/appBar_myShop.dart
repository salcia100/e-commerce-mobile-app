import 'package:flutter/material.dart';

class MyShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,//backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        ' My Shop',
        style: TextStyle(
           color: Theme.of(context).textTheme.titleLarge?.color,
          fontSize: 18,
          fontFamily: 'Product Sans',
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
