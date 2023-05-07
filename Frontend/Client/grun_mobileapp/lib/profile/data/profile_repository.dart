import 'package:grun_mobileapp/profile/data/network/profile_service.dart';

class ProfileRepository {
  static Future<String> getUser() async {
    return await ProfileService.getUser();
  }
}
