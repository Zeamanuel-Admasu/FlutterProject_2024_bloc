import 'package:flutter/material.dart';

class FoodImageWidget extends StatelessWidget {
  final String imagePath;

  const FoodImageWidget({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          height: 180,
          width: 180,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
