import 'dart:convert';

import '../../data/main_repository.dart';
import '../entity/products_dto.dart';

class GetLessPaidProductsUseCase {
  static Future<List<ProductDTO>> getLessPaidProducts() async {
    final response = await MainRepository.getLessPaidProducts();
    List<ProductDTO> products = [];
    final mapProducts = json.decode(response)['data'];
    mapProducts.forEach((product) {
      products.add(ProductDTO.fromJson(product['_id']));
    });

    return products;
  }
}
