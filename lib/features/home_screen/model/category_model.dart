import 'package:flutter/cupertino.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  bool isSelected;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
}