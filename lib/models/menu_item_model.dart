import 'package:flutter/material.dart';

class MenuItemModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  MenuItemModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}