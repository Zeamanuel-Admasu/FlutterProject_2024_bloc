// ignore: file_names
import 'package:flutter/material.dart';

Color getColorForLetter(int index) {
  List colors = [
    const Color.fromARGB(255, 0, 196, 16),
    const Color.fromARGB(255, 242, 247, 1),
    const Color.fromARGB(255, 255, 105, 36),
    const Color.fromARGB(255, 0, 89, 255),
    const Color.fromARGB(255, 255, 105, 36),
    const Color.fromARGB(255, 242, 247, 1),
    const Color.fromARGB(255, 0, 196, 16)
  ];
  return colors[index % colors.length];
}
