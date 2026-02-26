import 'package:flutter/material.dart';

import '../../data/models/categories_response_model.dart';

class CategoryController with ChangeNotifier {
  CategoryModel _category = const CategoryModel(id: 42424242424242);

  CategoryModel get category => _category;

  void setCategory(CategoryModel category) {
    _category = category;
    notifyListeners();
  }
}
