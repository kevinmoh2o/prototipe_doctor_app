import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  // Controladores para email y password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Para mostrar/ocultar la contraseña
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  // Para mostrar un indicador de carga mientras se procesa el login
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Cambia la visibilidad de la contraseña
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Ejemplo de acción de login (puedes llamar a tu repositorio o caso de uso aquí)
  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    // Simulación de llamada a un backend
    await Future.delayed(const Duration(seconds: 2));

    // Aquí manejarías la respuesta real (éxito o error)
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
