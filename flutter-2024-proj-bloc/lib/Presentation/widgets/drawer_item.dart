import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  DrawerItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(
          title,
          style:const TextStyle(fontSize: 16),
        ),
        onTap: onTap,
      ),
    );
  }
}
