
import 'package:flutter/material.dart';



import 'CartPage.dart';
import 'DatabaseHelper.dart';
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
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Map productDetails = {};
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
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addToCart() async {
    Map<String, dynamic> cartItem = {
      'id': productDetails['id'],
      'name': productDetails['title'],
      'price': productDetails['price'],
      'image':productDetails['image'],
      'quantity': 1
    };

    await _dbHelper.addToCart(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added to cart!')),
    );
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
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200]),
                        child: const Icon(Icons.arrow_back_ios_new))),
                const Spacer(),
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200]),
                    child: const Icon(Icons.favorite, color: Colors.red)),
                const SizedBox(width: 25),
                GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      },
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: const Icon(Icons.shopping_cart)),
                ),
              ],
            ),
            productDetails.isEmpty
                ? const Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 300,
                          child: Center(child: Image.network(productDetails['image']))),
                      const SizedBox(height: 30),
                      Text(
                        productDetails['title'] ?? '',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
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
                                  Icon(
                                    Icons.star,
                                    color: Colors.lightBlueAccent,
                                  ),
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
                        const SizedBox(width: 10),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '94%',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                                  Icon(
                                    Icons.question_answer,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("8"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
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
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "from 4\$ per month",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 70,
                                ),
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                )
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
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          addToCart();
                        },
                        child: SizedBox(
                          width: 500,
                          height: 50,
                          child: Card(
                            color: Colors.lightGreenAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(child: Text('Delivery on 26 Oct'))
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
