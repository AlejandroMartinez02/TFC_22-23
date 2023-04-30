import 'package:grun_mobileapp/splash/data/datastore/secure_storage_service.dart';
import 'package:grun_mobileapp/splash/data/network/response/check_token_response.dart';
import 'package:grun_mobileapp/splash/data/network/splash_client.dart';

class SplashService {
  static Future<bool> checkToken() async {
    final token = await SecureStorageService.getToken();
    final response =
        CheckTokenResponse.fromRawJson(await SplashClient.checkToken(token));
    return response.status == "200" ? true : false;
  }

  static Future<bool> getToken() async {
    return await SecureStorageService.getToken() != '' ? true : false;
  }
}
