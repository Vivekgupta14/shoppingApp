import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';  // Import your DatabaseHelper

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Future<List<Map<String, dynamic>>> _wishlistItems;

  @override
  void initState() {
    super.initState();
    _refreshWishlistItems();
  }

  // Load wishlist items
  void _refreshWishlistItems() {
    _wishlistItems = DatabaseHelper().getWishlistItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.greenAccent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _wishlistItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());  // Show loading indicator while fetching data
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading wishlist'));  // Show error message if there’s an issue
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items in wishlist'));  // Show message if wishlist is empty
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(item['image']),
                    title: Text(item['name']),
                    subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                                   DatabaseHelper().deleteWishlistItem(item['id']);
                                   setState(() {
                                   _wishlistItems = DatabaseHelper().getCartItems();
                      },);}
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
