import 'package:flutter/material.dart';
class Deliverypage extends StatelessWidget {
  const Deliverypage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 250,),
          Center(
            child:
            Text("Product will be delivered at your home soon..",textAlign:TextAlign.center,style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
    );
  }
}
