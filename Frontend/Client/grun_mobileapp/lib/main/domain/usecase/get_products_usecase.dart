import 'dart:convert';

import 'package:grun_mobileapp/main/data/main_repository.dart';
import 'package:grun_mobileapp/main/domain/entity/products_dto.dart';

class GetProductsUseCase {
  static Future<List<ProductDTO>> init() async {
    final response = await MainRespository.getProducts();
    final Map<String, dynamic> productsMap = json.decode(response);
    final List<ProductDTO> products = [];
    productsMap['data']
        .forEach((product) => {products.add(ProductDTO.fromJson(product))});
    return products;
  }
}
