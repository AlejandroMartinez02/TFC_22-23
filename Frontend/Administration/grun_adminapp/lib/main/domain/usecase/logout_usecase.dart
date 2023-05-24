import '../../data/main_repository.dart';

class LogoutUseCase {
  static logout() async {
    await MainRepository.logout();
  }
}
