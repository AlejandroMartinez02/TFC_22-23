import 'package:flutter/material.dart';

class Constants {
  //*--- Texts and values ---*//

  //---Login---//
  static const labelPasswordLogin = 'Contraseña';
  static const loginTitle = 'Inicio de sesión';
  static const wrongLogin = 'El usuario o la contraseña son incorrectos';
  static const accountLocked =
      'La cuenta está bloqueada, por favor inicie sesión más tarde';
  static const logoutAutoMessage =
      'Tu sesión ha caducado. Por favor, inicia sesión de nuevo';

  static const addToCartButtonText = "Añadir al carrito";

  //---Others---//
  static const borderRadius = 30.0;
  static const secondaryColor = Color.fromARGB(255, 43, 181, 114);
  static const componentAnimationDuration = Duration(milliseconds: 500);
  static const slogan = 'Sei Vegan, Sei Grün';
  static const serverFailedText =
      'Ha ocurrido algo inesperado, por favor inténtelo de nuevo';

  //*--- Static photos ---//
  static const lightLogoApp = 'assets/light_logo.png';
  static const darkLogoApp = 'assets/dark_logo.png';

//*--- IP's ---*//
  static const httpAPI = '192.168.1.101:8080';
}
