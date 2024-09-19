import 'package:buy_smart/CustomBottomNav.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';

class CartPage extends StatefulWidget {
  final int productId;
  const CartPage({super.key, required this.productId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isChecked = false;
  Map productDetails = {};
  int _selectedIndex = 0;
  final ApiService apiService = ApiService();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }
  Future<void> fetchProductDetails() async {
    try {
      final details = await apiService.fetchProductDetails(widget.productId);
      setState(() {
        productDetails = details;
        print(productDetails);
      });
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Card(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                   Row(
                    children: [
                      const Text(
                        '  Cart',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(), // Spacer will take up available space instead of hard-coded width
                      Container(width: 50,  // Adjust the width and height based on the size you want
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,  // This makes the container circular
                            color: Colors.grey[200],),
                          child: const Icon(Icons.info_outline, size: 30)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Bangalore',
                      prefixIcon: const Icon(Icons.location_on),
                      suffixIcon: const Icon(Icons.arrow_forward_ios_outlined),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
             height: 620,
            child: Card(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked, // Current state of the checkbox
                        onChanged: (bool? value) {
                          setState(() {
                          });
                        },
                        ),
                      const Text("Select all", // Update label based on state
                        style: TextStyle(
                            fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 200,),
                      Icon(Icons.upload),
                      SizedBox(width: 10,),
                      Icon(Icons.edit)
                    ],
                  ),

                  Row(
                    children: [
                      Checkbox(
                        value: isChecked, // Current state of the checkbox
                        onChanged: (bool? value) {
                          setState(() {
                          });
                        },
                      ),
                      SizedBox(height: 90,
                      width: 90,
                          child:productDetails.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              :  Image.network(
                              productDetails['image'])),
                          // : const Text('Product ID is missing!'),),
                      SizedBox(
                        width: 200,
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              Text(
                                productDetails['title'] ?? '',
                                style: const TextStyle(
                                    fontSize: 14,),
                                maxLines: 2,  // Limit text to 2 lines
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10,),
                              Text("\$${productDetails['price']}",
                                style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
