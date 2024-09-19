
import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Center(
            child: Icon(Icons.home, color: Colors.greenAccent),
          ),
          label: 'Home',  // Label is still required but hidden
        ),
        BottomNavigationBarItem(
          icon: Center(
            child: Icon(Icons.category, color: Colors.greenAccent),
          ),
          label: 'Catalog',
        ),
        BottomNavigationBarItem(
          icon: Center(
            child: Icon(Icons.shopping_cart, color: Colors.greenAccent),
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Center(
            child: Icon(Icons.favorite, color: Colors.greenAccent),
          ),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Center(
            child: Icon(Icons.person, color: Colors.greenAccent),
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      showSelectedLabels: false,  // Hide labels
      showUnselectedLabels: false,  // Hide labels
      selectedIconTheme: const IconThemeData(
        size: 30,  // Consistent size for selected icons
      ),
      unselectedIconTheme: const IconThemeData(
        size: 30,  // Consistent size for unselected icons
      ),
      type: BottomNavigationBarType.fixed,  // Ensure the type is fixed to avoid shifting
    );
  }
}
