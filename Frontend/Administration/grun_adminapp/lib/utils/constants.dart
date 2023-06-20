import 'package:flutter/material.dart';

class Constants {
  //*--- Texts and values ---*//

  //---Login---//
  static const labelPassword = 'Contraseña';
  static const loginTitle = 'Inicio de sesión';
  static const loginRegisterText = '¿Quieres ser Grün? ';
  static const loginRegisterLink = '¡Regístrate!';
  static const passwordError = '¡Debes escribir la contraseña!';
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
  static const orders = 'Pedidos';
  static const graphics = 'Gráficos';
  static const tables = 'Mesas';
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
  static const addDishSuccess = '¡Plato creado correctamente!';
  static const addDishError =
      'Ha ocurrido un error creando el plato, por favor inténtelo más tarde';

  //---Category---//
  static const categoryTitle = 'Panel de administración de las categorías';
  static const nameCategoryText = 'Nombre';
  static const descriptionCategoryText = 'Descripción';
  static const photoCategoryText = 'Foto';
  static const addCategory = 'Añadir categoría';
  static const addCategorySuccess = 'Categoría creada correctamente!';
  static const addCategoryError =
      'Ha ocurrido un error creando la categoría, por favor inténtelo más tarde';
  static const nameCategoryHint = 'Tostas';
  static const descriptionCategoryHint =
      '¡Las mejores tostas de toda la comarca!';
  static const nameCategoryError = '¡Debes escribir un nombre!';
  static const descriptionCategoryError = '¡Debes escribir una descripcion!';
  static const deleteCategory = 'Eliminar categoría';
  static const deleteCategoryTitle =
      '¿Está seguro de eliminar esta categoría? Esta acción es irreversible';
  static const deleteCategorySuccess = '¡Categoría eliminada correctamente!';
  static const deleteCategoryError =
      'Ha ocurrido un error eliminando la categoría, por favor inténtelo más tarde';
  static const updateCategory = 'Actualizar categoría';
  static const updateCategorySuccess = 'Categoria actualizada correctamente!';
  static const updateCategoryError =
      'Ha ocurrido un error actualizando la categoria, por favor inténtelo más tarde';
  static const categoryCreated =
      'Esta categoría ya existe, por favor intente crear otra';

  //---Worker---//
  static const workerTitle = 'Panel de administración de los trabajadores';
  static const addWorker = 'Añadir trabajador';
  static const addWorkerSuccess = '¡Trabajador añadido correctamente!';
  static const addWorkerError =
      'Ha ocurrido un error creando al trabajador, por favor inténtelo más tarde';
  static const workerName = 'Nombre';
  static const workerLastname = 'Apellidos';
  static const workerEmail = 'Correo electrónico';
  static const workerPhone = 'Teléfono móvil';
  static const workerMaritalStatus = 'Emparejado';
  static const workerSalary = "Salario";
  static const workerAge = 'Edad';
  static const workerRole = 'Rol';
  static const workerPassword = 'Contraseña';
  static const workerNameHint = 'Guillermo';
  static const workerLastnameHint = 'Baeza';
  static const workerEmailHint = 'gm2003@gmail.com';
  static const workerPhoneHint = '695811734';
  static const workerMaritalStatusHint = 'Soltero';
  static const workerSalaryHint = "1000";
  static const workerAgeHint = '21';
  static const workerNameError = '¡Debes escribir un nombre!';
  static const workerLastnameError = '¡Debes escribir un apellido';
  static const workerSalaryError = '¡Debes escribir un salario válido!';
  static const single = 'Soltero';
  static const married = 'Casado';
  static const other = 'Otro';
  static const engagement = 'Emparejado';
  static const chefText = 'Cocinero';
  static const chefValue = 'Chef';
  static const waiterText = 'Camarero';
  static const waiterValue = 'Waiter';
  static const adminText = 'Administrador';
  static const adminValue = 'Admin';
  static const birthDate = 'Fecha de nacimiento';
  static const deleteWorker = 'Eliminar trabajador';
  static const deleteWorkerTitle =
      '¿Está seguro de eliminar este trabajador? Esta acción es irreversible';
  static const deleteWorkerSuccess = '¡Trabajador eliminado correctamente!';
  static const deleteWorkerError =
      'Ha ocurrido un error eliminando al trabajador, por favor inténtelo más tarde';
  static const updateWorker = 'Actualizar trabajador';
  static const updateWorkerSuccess = '¡Trabajador actualizado correctamente!';
  static const updateWorkerError =
      'Ha ocurrido un error actualizando el trabajador, por favor inténtelo más tarde';

  //---Orders---//
  static const orderCost = 'Coste total';
  static const orderDate = 'Fecha de creación';
  static const orderState = 'Estado';
  static const orderTitle = 'Panel de administración de los pedidos';
  static const totalCost = 'Ganancias brutas';
  static const deleteOrder = 'Eliminar pedido';
  static const deleteOrderTitle =
      '¿Está seguro de eliminar este pedido? Esta acción es irreversible';
  static const deleteOrderSuccess = '¡Pedido eliminado correctamente!';
  static const deleteOrderError =
      'Ha ocurrido un error eliminando el pedido, por favor inténtelo más tarde';
  static const orderSummary = 'Resumen del pedido';
  static const orderLineName = 'Nombre del producto';
  static const orderLineCount = 'Cantidad';
  static const orderLineCost = 'Coste';

  //---Tables---//
  static const tableTitle = 'Panel de administración de las mesas';
  static const tableNumberText = 'Número de mesa';
  static const tableNumberHint = '10';
  static const isInUseText = '¿Está en uso?';
  static const addTable = 'Añadir mesa';
  static const addTableSuccess = 'Mesa añadida correctamente';
  static const addTableError =
      'Ha ocurrido un error creando la tabla, por favor inténtelo más tarde';
  static const invalidNumberTable = 'Ese número de mesa ya está en uso';
  static const deleteTableTitle =
      '¿Deseas eliminar esta mensa? Esta acción es irreversible.';
  static const deleteTable = 'Eliminar mesa';
  static const deleteTableSuccess = 'Mesa eliminada correctamente';
  static const deleteTableError =
      'Ha ocurrido un error eliminando la mesa, por favor inténtelo de nuevo';
  static const updateTableTitle = 'Actualizar mesa';
  static const updateTable = 'Actualizar mesa';
  static const updateTableSuccess = 'Mesa actualizada correctamente';
  static const updateTableError =
      'Ha ocurrido un error actualizando la mesa, por favor inténtelo de nuevo';
  static const anyChangeDoneTable =
      'Debes realizar algún cambio para poder actualizar la mesa';

  //---Others---//
  static const borderRadius = 30.0;
  static const usedData =
      'Algún dato ya está en uso, por favor cambielo y vuelva a intentarlo';
  static const secondaryColor = Color.fromARGB(255, 21, 98, 61);
  static const redColor = Color.fromARGB(255, 176, 48, 39);
  static const blueColor = Color.fromARGB(255, 21, 89, 144);
  static const componentAnimationDuration = Duration(milliseconds: 500);
  static const maxAgeWorker = Duration(days: 365 * 65);
  static const minAgeWorker = Duration(days: 365 * 18);
  static const toastDuration = Duration(seconds: 3);
  static const nameFieldError = '¡Debes escribir tu nombre! :)';
  static const lastnameFieldError = '¡Debes escribir el apellido! :)';
  static const addressFieldError = '¡Debes escribir el dirección! :)';

  static const slogan = 'Sei Vegan, Sei Grün';
  static const appName = 'Grün';
  static const error = 'ERROR';
  static const waiting = 'Espere';
  static const accept = 'Aceptar';
  static const errorPageText =
      '¡Oh no! Parece que tenemos algún problema, lo intentaremos solucionar lo antes posible';

  //*--- Static photos ---//
  static const lightLogoApp = 'assets/light_logo.png';
  static const darkLogoApp = 'assets/dark_logo.png';
  static const noImagePhoto = 'assets/no-image.png';

//*--- IP's ---*//
  static const httpAPI = '10.2.249.161:8080';
  static const cloudName = 'ddcjuozld';
  static const uploadPreset = 'tfc2223';
  static const folderCloudName = 'Restaurant';
  static const apiKey = '264994649263339';
  static const apiSecreKey = 'e2DOUb3VIJ9iCufBbHBfyaMR-e8';

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

  static String getTitle(bool isBestSelling, int currentBestNumOrders) {
    if (isBestSelling) {
      return 'Los 5 productos más vendidos de los ultimos $currentBestNumOrders pedidos';
    } else {
      return 'Los 5 productos menos vendidos de los ultimos $currentBestNumOrders pedidos';
    }
  }
}
