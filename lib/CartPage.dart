
import 'package:buy_smart/DeliveryPage.dart';

import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> _cartItems;
  late Future<double> _totalAmount;

  @override
  void initState() {
    super.initState();
    _refreshCart();
  }
  void _refreshCart(){
    setState(() {
      _cartItems = DatabaseHelper().getCartItems();
      _totalAmount = DatabaseHelper().getTotalAmount();
    });
  }
  void _clearCart() async {
    await DatabaseHelper().clearTable('cart');
    _refreshCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cart cleared successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(onPressed: (){
            _clearCart();
          print('cart cleared');
          }, icon: const Icon(Icons.delete_outline))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 650,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _cartItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('Your cart is empty'));
                }

                final cartItems = snapshot.data!;

                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final totalPrice = item['price'] * item['quantity']; // Calculate total price

                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          item['image'], // Use Image.asset if the image is local
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item['name'], maxLines: 2),
                        subtitle: Text("Quantity: ${item['quantity']}   \$${item['price']}",
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),), // Display price
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            DatabaseHelper().deleteCartItem(item['id']);
                            setState(() {
                              _cartItems = DatabaseHelper().getCartItems();
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10,),
          FutureBuilder<double>(
            future: _totalAmount,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final totalAmount = snapshot.data ?? 0.0;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
           SizedBox(height: 50,
            child: GestureDetector(onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Deliverypage()),
              );
            },
              child: const Card(
                child:Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                ),
            ),
          ),
        ],
      ),
    );
  }
}
