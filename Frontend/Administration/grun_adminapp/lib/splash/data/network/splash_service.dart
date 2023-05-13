import '../datastore/secure_storage_service.dart';
import 'response/check_token_response.dart';
import 'splash_client.dart';

class SplashService {
  static Future<bool> checkToken() async {
    final token = await SecureStorageService.getToken();
    final response =
        CheckTokenResponse.fromRawJson(await SplashClient.checkToken(token));
    final isTokenValid = response.status == "200" ? true : false;
    if (!isTokenValid) await SecureStorageService.deleteToken();
    return isTokenValid;
  }

  static Future<String?> getToken() async {
    return await SecureStorageService.getToken();
  }
}
