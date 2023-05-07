import 'package:grun_mobileapp/profile/data/network/profile_client.dart';
import 'package:grun_mobileapp/register/data/datastore/secure_storage_service.dart';

class ProfileService {
  static Future<String> getUser() async {
    final token = await SecureStorageService.getToken();
    return await ProfileClient.getUser(token: token);
  }
}
