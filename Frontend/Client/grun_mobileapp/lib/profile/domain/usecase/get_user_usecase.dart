import 'dart:convert';

import '../../data/network/response/user_dto.dart';
import '../../data/profile_repository.dart';

class GetUserUseCase {
  static Future<UserDTO> init() async {
    final response = await ProfileRepository.getUser();
    final Map<String, dynamic> user = json.decode(response);
    return UserDTO.fromJson(user['data']!);
  }
}
