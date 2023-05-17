import 'network/main_service.dart';

class MainRepository {
  static logout() async {
    await MainService.logout();
  }
}
