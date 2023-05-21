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
  static const updateUserError =
      'Ha ocurrido un error actualizando el usuario, por favor inténtelo más tarde';
  static const deleteUserError =
      'Ha ocurrido un error eliminando  el usuario, por favor inténtelo más tarde';
  static const anyChangesDoneUser =
      'Debes realizar algún cambio para poder actualizar el usuario';
  static const deleteUser =
      '¿Está seguro de eliminar este usuario? Esta acción es irreversible';
  static const deleteUserButton = 'Borrar usuario';
  static const deleteUserSuccess = '¡Usuario eliminado correctamente!';
  static const changePhoto = 'Cambiar imagen';

  //---Dishes---//
  static const dishTitle = 'Panel de administración de los platos';
  static const dishNameText = 'Nombre';
  static const ingredientsText = 'Ingredientes';
  static const costDishText = 'Precio';
  static const photoDishText = 'Foto';
  static const categoryDishText = 'Categoria';
  static const descriptionDishText = 'Descripción';
  static const deleteDishTitle =
      '¿Está seguro de eliminar este plato? Esta acción es irreversible';
  static const nameDishError = '¡Debes escribir un nombre!';
  static const descriptionDishError = '¡Debes escribir una descripcion!';
  static const costDishError = '¡Debes escribir un número  válido!';
  static const ingredientsDishError = '¡Debes escribir algún ingrediente!';
  static const updateDish = 'Actualizar plato';
  static const updateDishSuccess = '¡Plato actualizado correctamente!';
  static const updateDishError =
      'Ha ocurrido un error actualizando el plato, por favor inténtelo más tarde';
  static const anyChangeDoneDish =
      'Debes realizar algún cambio para poder actualizar el plato';
  static const nameDishHint = 'Cheesevurger';
  static const descriptionDishHint = 'Una hamburguesa riquísima';
  static const costDishHint = '10';
  static const ingredientsDishHint =
      'Proteína de guisante, agua, levadura nutricional...';
  static const deleteDish = 'Eliminar plato';
  static const deleteDishSuccess = '¡Plato eliminado correctamente!';
  static const deleteDishError =
      'Ha ocurrido un error eliminando  el plato, por favor inténtelo más tarde';
  static const addDish = 'Añadir plato';
  static const selectCategory = 'Selecciona una categoria';
  static const createDish = '¡Añade un plato!';
  static const createDishButtonText = 'Añadir plato';
  static const addDishSuccess = '¡Plato creado correctamente!';
  static const addDishError =
      'Ha ocurrido un error creando el plato, por favor inténtelo más tarde';

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
  static const noImagePhoto = 'assets/no-image.png';

//*--- IP's ---*//
  static const httpAPI = '192.168.1.104:8080';
  static const imageUrlApi = 'api.cloudinary.com';
  static const cloudName = 'ddcjuozld';
  static const uploadPreset = 'tfc2223';
  static const folderCloudName = 'Restaurant';
  static const apiKey = '264994649263339';
  static const apiSecreKey = 'e2DOUb3VIJ9iCufBbHBfyaMR-e8';
  static const imageUrlApi2 =
      '/v1_1/ddcjuozld/image/upload?upload_preset=tfc2223';

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
