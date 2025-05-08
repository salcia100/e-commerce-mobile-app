import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/theme_controller.dart';
import 'package:inscri_ecommerce/screens/login.dart';
import 'package:inscri_ecommerce/screens/My_shop/my_shop_screen.dart';
import 'package:inscri_ecommerce/screens/my_sales/my_sales_screen.dart';
import 'package:inscri_ecommerce/screens/notifications/notifications_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    // N7adrou état actuel mta3 thème (light wela dark)
    bool isDarkMode = ThemeController.themeNotifier.value == ThemeMode.dark;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER - Profil utilisateur
          ProfileInfo(),

          /// MENUS PRINCIPAUX
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
            icon: Icons.business_center,
            text: "My Shop",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyShopScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.receipt_long,
            text: "My Orders",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.shopping_bag,
            text: "My Sales",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SalesScreen()),
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
          _buildMenuItem(
            icon: Icons.notifications,
            text: "Notifications",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          Divider(),

          /// AUTRES OPTIONS
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

          Spacer(),

          /// BOUTON LOGOUT
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

          /// SWITCH LIGHT / DARK MODE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildThemeButton(Icons.wb_sunny, "Light",
                      isSelected: !isDarkMode, onTap: () {
                    ThemeController.themeNotifier.value = ThemeMode.light;
                    setState(() {});
                  }),
                  _buildThemeButton(Icons.nightlight_round, "Dark",
                      isSelected: isDarkMode, onTap: () {
                    ThemeController.themeNotifier.value = ThemeMode.dark;
                    setState(() {});
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// WIDGET MTA3 MENU
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
      tileColor:
          isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
    );
  }

  /// BOUTON DE SWITCH MODE SOMBRE / CLAIR
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

