import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/models/models.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ProductsService extends ChangeNotifier {
  final List<Product> products = [];
  bool isLoading = true;

  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(
      Constants.httpAPI,
      '/api/dishes/all',
    );
    final response = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(response.body);
    productsMap['data'].forEach((product) => {
          products.add(
            Product.fromJson(product),
          )
        });

    isLoading = false;
    notifyListeners();
    print(isLoading);
  }
}
