class Validations {
  static String? passwordValidator(String? value) {
    RegExp regExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{8,}$');
    return regExp.hasMatch(value ?? '')
        ? null
        : "La contraseña debe contener números, mayúsculas, minúsculas y símbolos";
  }

  static String? emailValidator(String? value) {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return regExp.hasMatch(value ?? '')
        ? null
        : "No es un correo electrónico válido";
  }
}
