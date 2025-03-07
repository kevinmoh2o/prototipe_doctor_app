import 'package:doctor_app/core/data/services/credential_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  final credentialService = CredentialService();

  LoginProvider() {
    // Al iniciar, puedes intentar recuperar credenciales si deseas
    _loadStoredCredentials();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    // Simulación: validación exitosa
    if (_rememberMe) {
      await credentialService.storeCredentials(
        emailController.text,
        passwordController.text,
      );
    } else {
      // Si no se desea recordar, limpiamos
      await credentialService.clearCredentials();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Cargar credenciales (opcional, por si deseas autocompletar)
  Future<void> _loadStoredCredentials() async {
    final creds = await credentialService.getCredentials();
    if (creds != null) {
      emailController.text = creds['email'] ?? '';
      passwordController.text = creds['password'] ?? '';
      _rememberMe = true; // Asumes que si hay credenciales, se "recordaron"
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
