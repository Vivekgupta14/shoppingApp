import 'package:buy_smart/CartProvider.dart';
import 'package:buy_smart/LoginPage.dart';
import 'package:buy_smart/ProductCard.dart';
import 'package:buy_smart/ProductDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CartPage.dart';
import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CartProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const HomePage()
      ),
    );
  }
}

