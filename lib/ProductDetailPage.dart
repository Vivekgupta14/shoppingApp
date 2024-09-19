import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CartPage.dart';
import 'api_service.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map productDetails = {};
  bool isExpanded = false;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      final response = await apiService.fetchProductDetails(widget.productId);
        setState(() {
          productDetails = response;
          print(productDetails);
        });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                GestureDetector(onTap: () {
                  Navigator.pop(context);
                },
                    child:  Container(width: 50,  // Adjust the width and height based on the size you want
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,  // This makes the container circular
                            color: Colors.grey[200]),
                        child: const Icon(Icons.arrow_back_ios_new))),
                const Spacer(),
                Container(width: 50,  // Adjust the width and height based on the size you want
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,  // This makes the container circular
                        color: Colors.grey[200]),
                    child: const Icon(Icons.favorite, color: Colors.red)),
                const SizedBox(width: 25),
                Container(width: 50,  // Adjust the width and height based on the size you want
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,  // This makes the container circular
                      color: Colors.grey[200],),
                    child: const Icon(Icons.shopping_cart)),
              ],
            ),
            productDetails.isEmpty
                ? const Expanded(child: Center(
                child: CircularProgressIndicator()))
                : Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                   child: SingleChildScrollView(
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      const SizedBox(height: 10),
                      SizedBox(height: 300, child: Center(child: Image.network(
                          productDetails['image']))),
                      const SizedBox(height: 30),
                      Text(
                        productDetails['title'] ?? '',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children: [
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.star,
                                        color: Colors.lightBlueAccent,),
                                      Text(
                                        "  4.8",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "  117 reviews",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.thumb_up, color: Colors.green,),
                                    SizedBox(width: 10,),
                                    Text('94%', style: TextStyle(
                                      fontSize: 15,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.question_answer,
                                        color: Colors.grey,),
                                      const SizedBox(width: 10,),
                                      Text("8"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 500,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "\$${productDetails['price']}",
                                  style: const TextStyle(fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "from 4\$ per month", style: TextStyle(
                                    color: Colors.grey
                                ),),
                                const SizedBox(
                                  width: 70,
                                ),
                                const Icon(
                                  Icons.info_outline, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          child: Text(
                            productDetails['description'] ?? '',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      SizedBox(
                        width: 500,
                        child: Card(
                          color: Colors.lightGreenAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextButton(onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return  CartPage(productId: widget.productId);
                            },),);
                          },
                              child: const Text('Add to Cart', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Center(child: Text('Delivery on 26 Oct'))

                      // Text(productDetails['description'] ?? ''),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
