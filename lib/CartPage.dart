import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = DatabaseHelper().getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }

          final cartItems = snapshot.data!;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                leading: Image.network(
                  item['image'], // Use Image.asset if the image is local
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(item['name'],maxLines: 2,),
                subtitle: Text('Quantity: ${item['quantity']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    DatabaseHelper().deleteCartItem(item['id']);
                    setState(() {
                      _cartItems = DatabaseHelper().getCartItems();
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
