import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/login.dart';
import 'package:inscri_ecommerce/screens/My_shop/my_shop_screen.dart';
import 'package:inscri_ecommerce/screens/orders_history/orders_screen.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';
import 'package:inscri_ecommerce/screens/profile_sidebar/components/user_info.dart';
import 'package:inscri_ecommerce/screens/wishlist/wishlist_screen.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class ProfileSidebar extends StatefulWidget {
  @override
  State<ProfileSidebar> createState() => _ProfileSidebarState();
}

class _ProfileSidebarState extends State<ProfileSidebar> {
  bool isDarkMode = false; // Pour gérer le mode sombre

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER - Profil utilisateur
          ProfileInfo(),
          // MENU PRINCIPAL
          _buildMenuItem(
            icon: Icons.home,
            text: "Homepage",
            isSelected: true,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.shopping_bag,
            text: "My Shop",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyShopScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.shopping_bag,
            text: "My Orders",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.favorite,
            text: "My Wishlist",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistScreen()),
              );
            },
          ),

          Divider(),

          // AUTRES OPTIONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "OTHER",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _buildMenuItem(icon: Icons.settings, text: "Setting", onTap: () {}),
          _buildMenuItem(
              icon: Icons.support_agent, text: "Support", onTap: () {}),
          _buildMenuItem(
              icon: Icons.info_outline, text: "About us", onTap: () {}),

          Spacer(), // Espacement pour aligner le bouton "Log out" en bas

          // BOUTON LOG OUT
          _buildMenuItem(
              icon: Icons.logout,
              text: "Log out",
              onTap: () {
                SecureStorage.deleteToken();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }),

          // SWITCH MODE CLAIR / SOMBRE
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildThemeButton(Icons.wb_sunny, "Light",
                      isSelected: !isDarkMode, onTap: () {
                    setState(() {
                      isDarkMode = false;
                    });
                  }),
                  _buildThemeButton(Icons.nightlight_round, "Dark",
                      isSelected: isDarkMode, onTap: () {
                    setState(() {
                      isDarkMode = true;
                    });
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET POUR UN ÉLÉMENT DE MENU
  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
    );
  }

  // BOUTON POUR LE MODE CLAIR / SOMBRE
  Widget _buildThemeButton(IconData icon, String text,
      {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
