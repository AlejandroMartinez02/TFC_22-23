import 'package:flutter/material.dart';

class Constants {
  //*--- Texts and values ---*//

  //---Login---//
  static const labelPassword = 'Contraseña';
  static const loginTitle = 'Inicio de sesión';
  static const wrongLogin = 'El usuario o la contraseña son incorrectos';
  static const passwordError = '¡Debes escribir la contraseña!';
  static const accountLocked =
      'La cuenta está bloqueada, por favor inicie sesión más tarde';
  static const logoutAutoMessage =
      '¡Oh no! Parece que tu sesión ha caducado. Inicia sesión de nuevo para disfrutar de Grün :D';
  static const serverFailedText =
      'Ha ocurrido algo inesperado, por favor inténtelo de nuevo';

  //---Main---//
  static const addToCartButtonText = "Añadir al carrito";
  static const addedToCart = '¡Producto añadido al carrito!';
  static const orderSummary = 'Resumen del pedido';
  static const myOrders = 'Mis pedidos';
  static const payButtonText = 'Finalizar pedido';
  static const createdOrder = '¡Pedido enviado correctamente!';
  static const errorCreatedOrder =
      '¡Ha ocurrido un error creando tu pedido! Vuelve a intentarlo';
  static const total = 'Total:';
  static const selectTable = 'Seleccionar mesa';

  //---Others---//
  static const borderRadius = 30.0;
  static const secondaryColor = Color.fromARGB(255, 21, 98, 61);
  static const componentAnimationDuration = Duration(milliseconds: 500);
  static const toastDuration = Duration(seconds: 3);
  static const slogan = 'Sei Vegan, Sei Grün';
  static const webPage = 'www.grun.es';
  static const grunPhone = 'Teléfono: 695811734';
  static const grunAdress = 'Avinguda Rei Jaume I, 32';
  static const productTicketColumn = 'Producto';
  static const unitsTicketColumn = 'Unid.';
  static const costTicketColumn = 'Precio';
  static const totalCostTicketColumn = 'Total';
  static const appName = 'Grün';
  static const error = 'ERROR';
  static const turnBack = 'Volver atrás';
  static const waiting = 'Espere';
  static const cancel = 'Cancelar';
  static const accept = 'Aceptar';
  static const noAdmin =
      'Parece que no tienes permisos para entrar a esta aplicación... ¡Contacta con un administrador si es un error!';
  static const errorPageText =
      '¡Oh no! Parece que tenemos algún problema, lo intentaremos solucionar lo antes posible';
  static const noProducts =
      '¡Vaya!¡No hay productos! Contacta con tu administrador para resolver este problema.';

  //*--- Static photos ---//
  static const lightLogoApp = 'assets/light_logo.png';
  static const darkLogoApp = 'assets/dark_logo.png';

//*--- IP's ---*//
  static const httpAPI = '10.2.249.161:8080';
  static const httpSocket = 'http://10.2.249.161:3000';
}
