// ignore_for_file: unnecessary_null_comparison, unnecessary_getters_setters

import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../data/network/response/order_dto.dart';
import '../data/network/response/user_dto.dart';
import '../domain/usecase/usecase.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ProfileProvider extends ChangeNotifier {
  GlobalKey<FormState> changePasswordKey = GlobalKey();
  GlobalKey<FormState> updateUserKey = GlobalKey();

  late IO.Socket _socket;

  List<OrderDTO> orders = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  bool _isOrderLoading = true;
  bool get isOrderLoading => _isOrderLoading;
  set isOrderLoading(bool loading) => _isOrderLoading = loading;

  UserDTO _user = UserDTO(
      id: '', name: '', lastname: '', email: '', phoneNumber: '', address: '');
  UserDTO get user => _user;
  set user(UserDTO user) => _user = user;

  UserDTO _updatedUser = UserDTO(
      id: '', name: '', lastname: '', email: '', phoneNumber: '', address: '');
  UserDTO get updatedUser => _updatedUser;
  set updatedUser(UserDTO user) => _updatedUser = user;

  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  set isWaiting(bool waiting) => _isWaiting = waiting;

  String? _oldPassword = '';
  String? get oldPassword => _oldPassword;
  set oldPassword(String? password) => _oldPassword = password;

  String? _newPassword = '';
  String? get newPassword => _newPassword;
  set newPassword(String? newPass) => _newPassword = newPass;

  ProfileProvider() {
    getUser();
    _config();
  }

  void _config() {
    _socket = IO.io('https://tfc-api-2223-amm.herokuapp.com/', {
      'autoConnect': true,
      'transports': ['websocket']
    });
    _socket.onConnect((_) => print("CONNECTED"));
  }

  void getUser() async {
    try {
      if (user.id.isEmpty) {
        isLoading = true;
        notifyListeners();
        user = await GetUserUseCase.init();
        isLoading = false;
        notifyListeners();
      }
    } catch (ex) {
      isLoading = false;
      user.id = Constants.error;
      notifyListeners();
    }
  }

  Future<bool> logOut() async {
    try {
      await LogoutUseCase.logout();
    } catch (ex) {
      return false;
    }
    return true;
  }

  Future<int> changePassword() async {
    if (changePasswordKey.currentState!.validate()) {
      try {
        isWaiting = true;
        notifyListeners();
        final response = await ChangePasswordUseCase.changePassword(
            oldPassword: oldPassword!, newPassword: newPassword!);
        isWaiting = false;
        notifyListeners();
        return response;
      } catch (ex) {
        isWaiting = false;
        notifyListeners();
        return 500;
      }
    } else {
      return 0;
    }
  }

  Future<int> updateUser() async {
    if (updateUserKey.currentState!.validate()) {
      if (!user.equals(updatedUser)) {
        try {
          isWaiting = true;
          notifyListeners();
          final response =
              await UpdateUserUseCase.updateUser(user: updatedUser);
          isWaiting = false;
          notifyListeners();
          if (response == 200) {
            user = updatedUser;
          }
          return response;
        } catch (ex) {
          isWaiting = false;
          notifyListeners();
          return 500;
        }
      } else {
        return 100;
      }
    }
    return 0;
  }

  void copyUser() {
    _updatedUser = _user.copyWith();
  }

  void getOrders() async {
    try {
      isOrderLoading = true;
      notifyListeners();
      orders = await GetOrdersUseCase.getOrders();
      orders.sort((a, b) => b.date.compareTo(a.date));
      orders.forEach((order) {
        if (order.state == 'En cocina') createSocket(order);
      });
      isOrderLoading = false;
      notifyListeners();
    } catch (ex) {
      isOrderLoading = false;
      notifyListeners();
    }
  }

  void createSocket(OrderDTO order) {
    _socket.on(order.id, (data) {
      order.state = 'Finalizado';
      _socket.off(order.id);
      notifyListeners();
    });
  }
}
