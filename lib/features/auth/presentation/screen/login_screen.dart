import 'package:doctor_app/features/auth/presentation/provider/login_provider.dart';
import 'package:doctor_app/features/create_account/presentation/screen/main_form_create_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProv = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF4F47C2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // LOGO
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.health_and_safety,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Título
                  const Text(
                    'Onco 360',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtítulo
                  const Text(
                    'Bienvenido de nuevo\nInicia sesión para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // FORMULARIO
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email
                        const Text(
                          'Email:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: loginProv.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'ejemplo@correo.com',
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Contraseña
                        const Text(
                          'Contraseña:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: loginProv.passwordController,
                          obscureText: !loginProv.isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: '********',
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginProv.isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: loginProv.togglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // "Recordar" y "Olvidé la contraseña"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: loginProv.rememberMe,
                                  onChanged: (val) => loginProv.toggleRememberMe(val),
                                ),
                                const Text('Recordar'),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Manejar "Olvidé la contraseña"
                              },
                              child: const Text('Olvidé la contraseña'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Botón INICIAR SESIÓN
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: loginProv.isLoading
                                ? null
                                : () async {
                                    await loginProv.login();
                                    // TODO: Navegación tras login exitoso
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F47C2),
                              foregroundColor: Colors.white, // Texto blanco
                              textStyle: const TextStyle(fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: loginProv.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('INGRESAR'),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Íconos sociales (ejemplo)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // TODO: Manejar login con Facebook
                              },
                              icon: const Icon(Icons.facebook),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO: Manejar login con Google
                              },
                              icon: const Icon(Icons.g_mobiledata),
                              color: Colors.red,
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO: Manejar login con Apple
                              },
                              icon: const Icon(Icons.apple),
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // "¿No tienes cuenta?"
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const MainFormCreateScreen()),
                              );
                            },
                            child: Text(
                              '¿No tienes cuenta? Crea una nueva cuenta',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
