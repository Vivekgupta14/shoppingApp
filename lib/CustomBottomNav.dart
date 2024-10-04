import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';      // Import your HomePage

import 'CartPage.dart';      // Import your CartPage
import 'WishlistPage.dart';  // Import your WishlistPage

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()), // Navigate to CartPage
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishlistPage()), // Navigate to WishlistPage
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.greenAccent),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category, color: Colors.greenAccent),
          label: 'Catalog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart, color: Colors.greenAccent),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.greenAccent),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.greenAccent),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        _navigateToPage(context, index); // Navigate to the correct page
        onItemTapped(index); // Update the selected index
      },
      showSelectedLabels: false, // Hide labels
      showUnselectedLabels: false, // Hide labels
      selectedIconTheme: const IconThemeData(
        size: 30, // Consistent size for selected icons
      ),
      unselectedIconTheme: const IconThemeData(
        size: 30, // Consistent size for unselected icons
      ),
      type: BottomNavigationBarType.fixed, // Ensure the type is fixed to avoid shifting
    );
  }
}
