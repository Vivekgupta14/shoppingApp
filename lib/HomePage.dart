import 'dart:convert';
import 'package:buy_smart/Categories.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CustomBottomNav.dart';
import 'ProductCard.dart';
import 'ProductDetailPage.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List products = [];
  List productsCategory =[];
  int _selectedIndex = 0;
  final ApiService apiService = ApiService();
  // late String selectedFilter;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategory();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Future<void> fetchProducts() async {
  //   try {
  //     final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         products = json.decode(response.body);
  //       });
  //     } else {
  //       debugPrint('Failed to load products: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching products: $e');
  //   }
  // }
  Future<void> fetchProducts() async {
    try {
      final response = await apiService.fetchProducts();
      setState(() {
        products = response  ;
        print(products);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchCategory() async {
    try {
      final response = await apiService.fetchCategory();
      setState(() {
        productsCategory = response  ;
        print(productsCategory);
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  //
  // Future<void> fetchCategory() async {
  //   try {
  //     final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         productsCategory = json.decode(response.body);
  //         print('$productsCategory');
  //       });
  //     } else {
  //       debugPrint('Failed to load products: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching products: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopCard(),
            _buildCategoryTitle(),
            _buildCategoryGrid(),
            _buildFlashSaleSection(),
            _buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildTopCard() {
    return SizedBox(
      height: 300,
      child: Card(
        child: Column(
          children: [
            const SizedBox(height: 70),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(width: 50,  // Adjust the width and height based on the size you want
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,  // This makes the container circular
                      color: Colors.grey[200],),
                    child: Icon(Icons.discount, size: 35)),
                const Column(
                  children: [
                    Text(
                      'Delivery Address',
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      'Bangalore',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(width: 50,  // Adjust the width and height based on the size you want
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,  // This makes the container circular
                      color: Colors.grey[200],),
                    child: const Icon(Icons.notification_add, size: 35, color: Colors.black)),
              ],
            ),
            const SizedBox(height: 30),
            _buildSearchField(),
            const SizedBox(height: 15),
            _buildDeliveryBanner(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.black45),
        filled: true,
        fillColor: Colors.white70,
        hintText: 'Search the entire shop',
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDeliveryBanner() {
    return SizedBox(
      height: 60,
      width: 400,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.blueGrey,
        child: const Center(
          child: Text(
            'Delivery is 50% cheaper',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Widget _buildCategoryTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      ),
    );
  }


  Widget _buildFlashSaleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          const Text(
            'Flash Sale',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(width: 20),
          _buildFlashSaleTimer(),
        ],
      ),
    );
  }

  Widget _buildFlashSaleTimer() {
    return SizedBox(
      height: 40,
      width: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.blueGrey,
        child: const Center(
          child: Text(
            '2:59:23',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return products.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return ProductDetailPage( productId: product['id'],);
            },),);
          },
          child: ProductCard(
            imageUrl: product['image'],
            title: product['title'],
            price: product['price'].toString(),
          ),
        );
      },
    );
  }
  Widget _buildCategoryGrid() {
    if (productsCategory.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productsCategory.length,
          itemBuilder: (context, index) {
            return Categories(label: productsCategory[index]);
          },
        ),
      ),
    );
  }
}
