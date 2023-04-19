import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/models/models.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ProductService extends ChangeNotifier {
  final List<ProductDTO> products = [];
  bool isLoading = true;

  ProductService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.http(
        Constants.httpAPI,
        '/api/dishes/all',
      );
      final response = await http.get(url);
      final Map<String, dynamic> productsMap = json.decode(response.body);
      productsMap['data'].forEach((product) => {
            products.add(
              ProductDTO.fromJson(product),
            )
          });
    } catch (Exception) {}

    isLoading = false;
    notifyListeners();
  }
}
