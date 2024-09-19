import 'package:flutter/material.dart';
class Categories extends StatelessWidget {
  final String label;
  const Categories({super.key, required this.label,});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Center(
                child: Text('$label'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue,


                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
