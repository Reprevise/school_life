import 'package:flutter/material.dart';

class DrawerItem {
  DrawerItem({
    required this.title,
    required this.icon,
    // this.color,
    required this.func,
  }); // constructor

  String title; // Text along side icon
  IconData icon; // Icon displayed before text
  // Color color; // Color of icon and text
  Function func; // What to do when it's tapped
}
