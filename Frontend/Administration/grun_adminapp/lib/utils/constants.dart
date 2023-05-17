import 'package:flutter/material.dart';

class Constants {
  //*--- Texts and values ---*//

  //---Login---//
  static const labelPassword = 'Contraseña';
  static const loginTitle = 'Inicio de sesión';
  static const loginRegisterText = '¿Quieres ser Grün? ';
  static const loginRegisterLink = '¡Regístrate!';
  static const wrongLogin = 'El usuario o la contraseña son incorrectos';
  static const accountLocked =
      'La cuenta está bloqueada, por favor inicie sesión más tarde';
  static const logoutAutoMessage =
      '¡Oh no! Parece que tu sesión ha caducado. Inicia sesión de nuevo para disfrutar de Grün :D';
  static const noAdmin =
      'Parece que no tienes permisos para entrar a esta aplicación... ¡Contacta con un administrador si es un error!';

  //---Main---//
  static const welcomeToAdmin = '¡Bienvenid@!';
  static const users = 'Usuarios';
  static const dishes = 'Platos';
  static const categories = 'Categorias';
  static const workers = 'Trabajadores';
  static const errorLogout =
      'Ha ocurrido un error cerrando sesión, por favor inténtalo de nuevo';
  static const logout = 'Cerrar sesión';
  static const logoutTitle = '¿Estás seguro que quieres cerrar sesión?';

  //---Users---//
  static const userTitle = 'Panel de administración de los usuarios';
  static const nameText = 'Nombre';
  static const lastnameText = 'Apellidos';
  static const phoneText = 'Teléfono móvil';
  static const addressText = 'Dirección';
  static const emailAddressText = 'Correo electrónico';
  static const updateUser = 'Actualizar usuario';
  static const cancel = 'Cancelar';
  static const nameHint = 'David';
  static const lastnameHint = 'Ferrer';
  static const emailHint = 'pizca777@gmail.com';
  static const phoneHint = '695811734';
  static const addressHint = 'Clle Sella 4, 1D';
  static const updateUserSuccess = '¡Usuario actualizado correctamente!';
  static const actionUserError =
      'Ha ocurrido un error actualizando el usuario, por favor inténtelo más tarde';
  static const anyChangesDone =
      'Debes realizar algún cambio para poder actualizar el usuario';
  static const deleteUser =
      '¿Estás seguro de eliminar este usuario? Esta acción es irreversible';
  static const deleteUserButton = 'Borrar usuario';
  static const deleteSuccess = '¡Usuario eliminado correctamente!';

  //---Others---//
  static const borderRadius = 30.0;
  static const secondaryColor = Color.fromARGB(255, 21, 98, 61);
  static const redColor = Color.fromARGB(255, 176, 48, 39);
  static const blueColor = Color.fromARGB(255, 21, 89, 144);
  static const componentAnimationDuration = Duration(milliseconds: 500);
  static const toastDuration = Duration(seconds: 3);
  static const nameFieldError = '¡Debes escribir tu nombre! :)';
  static const lastnameFieldError = '¡Debes escribir el apellido! :)';
  static const addressFieldError = '¡Debes escribir el dirección! :)';

  static const slogan = 'Sei Vegan, Sei Grün';
  static const appName = 'Grün';
  static const error = 'ERROR';
  static const waiting = 'Espere';
  static const errorPageText =
      '¡Oh no! Parece que tenemos algún problema, lo intentaremos solucionar lo antes posible';

  //*--- Static photos ---//
  static const lightLogoApp = 'assets/light_logo.png';
  static const darkLogoApp = 'assets/dark_logo.png';

//*--- IP's ---*//
  static const httpAPI = '192.168.1.104:8080';
  static const httpSocket = 'http://192.168.1.104:3000';

//*--- Functions ---*//
  static Color pickColor(String state) {
    Color color;
    switch (state) {
      case 'En proceso':
        color = Colors.green;
        break;
      case 'Finalizado':
        color = Colors.red;
        break;
      case 'Entregando':
        color = Colors.white;
        break;
      default:
        color = Colors.orange;
    }

    return color;
  }
}
