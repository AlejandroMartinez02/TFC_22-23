import '/splash/data/datastore/secure_storage_service.dart';
import '/splash/data/network/response/check_token_response.dart';
import '/splash/data/network/splash_client.dart';

class SplashService {
  static Future<bool> checkToken() async {
    final token = await SecureStorageService.getToken();
    final response =
        CheckTokenResponse.fromRawJson(await SplashClient.checkToken(token));
    final isTokenValid = response.status == "200" ? true : false;
    if (!isTokenValid) await SecureStorageService.deleteToken();
    return isTokenValid;
  }

  static Future<bool> getToken() async {
    return await SecureStorageService.getToken() != '' ? true : false;
  }
}
