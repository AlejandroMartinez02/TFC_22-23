import '../../../utils/services/secure_storage_service.dart';

class MainService {
  static logout() async {
    await SecureStorageService.deleteToken();
  }
}
