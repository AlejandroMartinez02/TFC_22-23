import 'dart:convert';

import '../../data/user_respository.dart';
import '../entities/user_dto.dart';

class GetAllUsersUseCase {
  static Future<List<UserDTO>> getUsers() async {
    final response = await UserRepository.getUsers();
    final List<UserDTO> users = [];
    final usersMap = json.decode(response)['data'];
    usersMap.forEach((user) => users.add(UserDTO.fromJson(user)));
    return users;
  }
}
