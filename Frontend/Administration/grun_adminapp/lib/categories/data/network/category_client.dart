import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_selector/file_selector.dart';

import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/category_dto.dart';

class CategoryClient {
  static Future<String> getAllCategories({required String token}) async {
    final url = Uri.http(Constants.httpAPI, '/api/categories/all');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> addCategory(
      {required CategoryDTO category, required String token}) async {
    final url = Uri.http(Constants.httpAPI, '/api/categories/');
    final response = await http.post(url,
        body: category.toJson(), headers: {'Authorization': 'Bearer $token'});
    print(response);
    return response.body;
  }

  static Future<String> updateCategory(
      {required CategoryDTO category, required String token}) async {
    final url = Uri.http(Constants.httpAPI, '/api/categories/');
    final response = await http.patch(url,
        body: category.toJson(), headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> deleteCategory(
      {required String id,
      required String oldImage,
      required String token}) async {
    final url = Uri.http(Constants.httpAPI, '/api/categories/');
    final response = await http.delete(url,
        body: {"_id": id}, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      await _deleteImage(oldImage);
    }
    return response.body;
  }

  static Future<String> changeImage(XFile newImage, String oldImage) async {
    final cloudinary = Cloudinary.basic(cloudName: Constants.cloudName);
    final response = await cloudinary.unsignedUploadResource(
        CloudinaryUploadResource(
            uploadPreset: Constants.uploadPreset,
            filePath: newImage.path,
            resourceType: CloudinaryResourceType.image,
            folder: Constants.folderCloudName));
    await _deleteImage(oldImage);
    print("${response.secureUrl} SUUUUUUUUUUUUUU");
    return response.secureUrl!;
  }

  static Future _deleteImage(String oldImage) async {
    if (oldImage != '') {
      final cloudinaryDelete = Cloudinary.full(
          apiKey: Constants.apiKey,
          apiSecret: Constants.apiSecreKey,
          cloudName: Constants.cloudName);
      await cloudinaryDelete.deleteResource(url: oldImage);
    }
  }
}
