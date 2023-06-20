import '../../data/profile_repository.dart';

class LogoutUseCase {
  static logout() async {
    await ProfileRepository.logout();
  }
}
