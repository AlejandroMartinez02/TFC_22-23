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

  //---Others---//
  static const borderRadius = 30.0;
  static const secondaryColor = Color.fromARGB(255, 43, 181, 114);
  static const componentAnimationDuration = Duration(milliseconds: 500);
  static const nameFieldError = '¡Debes escribir tu nombre! :)';
  static const lastnameFieldError = '¡Debes escribir el apellido! :)';
  static const addressFieldError = '¡Debes escribir el dirección! :)';
  static const nameTextFiled = 'Nombre';
  static const lastnameTextField = 'Apellidos';
  static const phoneTextField = 'Teléfono móvil';
  static const addressTextField = 'Dirección';
  static const emailAddressTextField = 'Correo electrónico';
  static const slogan = 'Sei Vegan, Sei Grün';
  static const appName = 'Grün';
  static const error = 'ERROR';
  static const errorPageText =
      '¡Oh no! Parece que tenemos algún problema, lo intentaremos solucionar lo antes posible';

  //*--- Static photos ---//
  static const lightLogoApp = 'assets/light_logo.png';
  static const darkLogoApp = 'assets/dark_logo.png';

//*--- IP's ---*//
  static const httpAPI = '192.168.1.104:8080';

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
