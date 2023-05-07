import 'package:flutter/material.dart';

class Constants {
  //*--- Texts and values ---*//

  //---Login---//
  static const labelPasswordLogin = 'Contraseña';
  static const loginTitle = 'Inicio de sesión';
  static const loginRegisterText = '¿Quieres ser Grün? ';
  static const loginRegisterLink = '¡Regístrate!';
  static const wrongLogin = 'El usuario o la contraseña son incorrectos';
  static const accountLocked =
      'La cuenta está bloqueada, por favor inicie sesión más tarde';
  static const logoutAutoMessage =
      '¡Oh no! Parece que tu sesión ha caducado. Inicia sesión de nuevo para disfrutar de Grün :D';

  //---Register---//
  static const registerLoginText = '¿Ya eres Grün? ';
  static const registerLoginLink = '¡Inicia sesión!';
  static const registerTitle = '¡Hazte Grün!';
  static const registerFailedText =
      'El correo electrónico ya está en uso, por favor ingresa uno nuevo';

  //---Main---//
  static const mainTitle = '¡Lo más vendido!';
  static const personalData = 'Datos personales';
  static const accountData = 'Datos de la cuenta';
  static const addressData = 'Dirección';

  static const categoryTitle = 'Nuestro menú';
  static const accountDrawerText = 'Tu perfil';
  static const addToCartButtonText = "Añadir al carrito";

  //---Profile---//
  static String profileHeaderText(String name) => '¡Hola $name!';
  static const logoutQuestion = '¿Seguro que quieres cerrar sesión?';
  static const logoutText = 'Cerrar sesión';
  static const errorLogout =
      'Parece que ha habido un error intentando cerrar sesión, ¡inténtalo de nuevo!😁';
  static const cancel = 'Cancelar';

  //---Others---//
  static const borderRadius = 30.0;
  static const secondaryColor = Color.fromARGB(255, 43, 181, 114);
  static const componentAnimationDuration = Duration(milliseconds: 500);
  static const slogan = 'Sei Vegan, Sei Grün';
  static const error = 'ERROR';
  static const errorPageText =
      '¡Oh no! Parece que tenemos algún problema, lo intentaremos solucionar lo antes posible 😕';
  static const noProducts =
      'Parece que tenemos algún problema, ¡intentaremos solucionarlo lo antes posible!😁';

  //*--- Static photos ---//
  static const lightLogoApp = 'assets/light_logo.png';
  static const darkLogoApp = 'assets/dark_logo.png';

//*--- IP's ---*//
  static const httpAPI = '192.168.1.101:8080';
}
