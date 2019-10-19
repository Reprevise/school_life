import 'package:flutter/material.dart';

class DrawerItem {
  String title; // Text along side icon
  IconData icon; // Icon displayed before text
  Color color; // Color of icon and text
  Function func; // What to do when it's tapped
  DrawerItem({
    this.title,
    this.icon,
    this.color,
    this.func,
  }); // constructor
}