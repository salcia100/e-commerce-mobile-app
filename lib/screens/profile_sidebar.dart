import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/orders_history/orders_screen.dart';

class ProfileSidebar extends StatefulWidget {
  @override
  State<ProfileSidebar> createState() => _ProfileSidebarState();
}

class _ProfileSidebarState extends State<ProfileSidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFFFCBBA)),
          child: Center(
            child: Text(
              "Profile",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("My Orders"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrdersScreen()),
            );
          },
        ),
      ],
    ));
  }
}
