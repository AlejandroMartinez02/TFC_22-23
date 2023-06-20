class Validations {
  static String? passwordValidator(String? value) {
    RegExp regExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{8,}$');
    return regExp.hasMatch(value ?? '')
        ? null
        : "¡Cuidado! La contraseña debe ser segura";
  }

  static String? emailValidator(String? value) {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return regExp.hasMatch(value ?? '') ? null : "¡Correo no válido!";
  }

  static String? phoneValidator(String? value) {
    RegExp regExp = RegExp(r'^\+?(6\d{2}|7[1-9]\d{1})\d{6}$');

    return regExp.hasMatch(value ?? '')
        ? null
        : "¡Este número de teléfono no es válido!";
  }
}
