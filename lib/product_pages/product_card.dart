import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;  
  final double price;
  final String image;
  final Color backGroungColor;
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,  
    required this.backGroungColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        color: backGroungColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 5,),
          Text("\$$price",style: Theme.of(context).textTheme.bodySmall,),
          const SizedBox(height: 5,),
          Center(
            child: Image.asset(image,
            height: 175,
            ),
          ),
        ],
      ),
    );
  }
}
