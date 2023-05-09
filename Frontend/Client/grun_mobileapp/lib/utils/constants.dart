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

  //---Register---//
  static const registerLoginText = '¿Ya eres Grün? ';
  static const registerLoginLink = '¡Inicia sesión!';
  static const registerTitle = '¡Hazte Grün!';
  static const registerFailedText =
      'El correo electrónico ya está en uso, por favor ingresa uno nuevo';

  //---Main---//
  static const mainTitle = '¡Lo más vendido!';
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
  static const personalDataText = 'Mis datos personales';
  static const personalDataAppBar = 'Tu información personal';
  static const editProfileData = 'Editar mis datos';
  static const nameTextFiled = 'Nombre';
  static const lastnameTextField = 'Apellidos';
  static const phoneTextField = 'Teléfono móvil';
  static const addressTextField = 'Dirección';
  static const emailAddressTextField = 'Correo electrónico';
  static const editPassword = 'Cambiar mi contraseña';
  static const passwordTextField = 'Contraseña antigua';
  static const newPasswordTextField = 'Nueva contraseña';
  static const changePaswwordButton = 'Cambiar contraseña';
  static const changePasswordError =
      'Ha ocurrido un error cambiando la contraseña, por favor espere un tiempo para volver a hacerlo';
  static const changePasswordSuccess = '¡Contraseña cambiada exitosamente!';
  static const changePasswordFailed =
      'Tu antigua contraseña no coincide, por favor inténtalo de nuevo';

  static var waiting = 'Espere';
  static const editProfileDataTitle = 'Actualiza tu perfil';
  static const updateUser = 'Actualizar usuario';
  static const updateUserSuccess = '¡Usuario actualizado correctamente!';
  static const updateUserError =
      'Ha ocurrido un error actualizando tu usuario, por favor inténtelo más tarde';
  static const anyChangesDone =
      'Debes realizar algún cambio para poder actualizar tu usuario';

  //---Others---//
  static const borderRadius = 30.0;
  static const secondaryColor = Color.fromARGB(255, 43, 181, 114);
  static const componentAnimationDuration = Duration(milliseconds: 500);
  static const nameFieldError = '¡Debes escribir tu nombre! :)';
  static const lastnameFieldError = '¡Debes escribir tu apellido! :)';
  static const emailFieldError = '';
  static const phoneFieldError = '';
  static const addressFieldError = '¡Debes escribir tu dirección! :)';
  static const slogan = 'Sei Vegan, Sei Grün';
  static const error = 'ERROR';
  static const errorPageText =
      '¡Oh no! Parece que tenemos algún problema, lo intentaremos solucionar lo antes posible 😕';
  static const noProducts =
      'Lo sentimos, pero no hay productos disponibles. Puede ser que sea por renovación de menú...🤔';
  //*--- Static photos ---//
  static const lightLogoApp = 'assets/light_logo.png';
  static const darkLogoApp = 'assets/dark_logo.png';

//*--- IP's ---*//
  static const httpAPI = '192.168.1.104:8080';
}
