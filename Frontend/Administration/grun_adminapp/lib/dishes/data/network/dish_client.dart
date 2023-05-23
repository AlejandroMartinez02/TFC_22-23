import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_selector/file_selector.dart';

import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/dish_dto.dart';

class DishClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<String> getDishes({required String token}) async {
    final url = Uri.http(_baseUrl, '/api/dishes/all');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> getCategories({required String token}) async {
    final url = Uri.http(_baseUrl, '/api/categories/all');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> updateDish(
      {required String token, required DishDTO updatedDish}) async {
    final url = Uri.http(_baseUrl, '/api/dishes/');
    final response = await http.patch(url,
        body: updatedDish.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> deleteDish(
      {required String id, required String token}) async {
    final url = Uri.http(_baseUrl, '/api/dishes/');
    final response = await http.delete(url,
        body: {"_id": id}, headers: {'Authorization': 'Bearer $token'});
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
    final cloudinaryDelete = Cloudinary.full(
        apiKey: Constants.apiKey,
        apiSecret: Constants.apiSecreKey,
        cloudName: Constants.cloudName);

    if (oldImage != '') {
      await cloudinaryDelete.deleteResource(url: oldImage);
    }
    return response.secureUrl!;
  }

  static Future<String> addDish(
      {required DishDTO newDish, required String token}) async {
    final url = Uri.http(_baseUrl, '/api/dishes/');
    final response = await http.post(url,
        body: newDish.toJson(), headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
}
