import 'package:flutter/material.dart';
import 'package:gem_store/features/home_screen/model/category_model.dart';

class CategoriesData {
  static List<CategoryModel> categories = [
    CategoryModel(id: "0", name: "Women", icon: Icons.female),
    CategoryModel(id: "1", name: "Men", icon: Icons.male),
    CategoryModel(id: "2", name: "Accessories", icon: Icons.style),
    CategoryModel(id: "3", name: "Beauty", icon: Icons.spa),
  ];
}
