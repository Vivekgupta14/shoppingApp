import 'package:flutter/material.dart';

class CartProductCard extends StatelessWidget {
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  // final VoidCallback onIncreaseQuantity;
  // final VoidCallback onDecreaseQuantity;

  const CartProductCard({
    super.key,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    // required this.onIncreaseQuantity,
    // required this.onDecreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Checkbox
            Checkbox(
              value: true,
              onChanged: (bool? newValue) {
                // Handle checkbox toggle
              },
            ),
            // Product Image
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productImage),  // Assuming the image is a URL
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Product details (Name and Price)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '£${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity selector
            Row(
              children: [
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.black54,
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed:(){},
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.black54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
