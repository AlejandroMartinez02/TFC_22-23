import 'dart:convert';

import '../../data/user_respository.dart';

class DeleteUserUseCase {
  static Future<int> deleteUser({required String id}) async {
    final response = await UserRepository.deleteUser(id: id);
    return json.decode(response)['status'];
  }
}
