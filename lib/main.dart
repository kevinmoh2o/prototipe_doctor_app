import 'package:doctor_app/features/auth/presentation/provider/login_provider.dart';
import 'package:doctor_app/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Onco 360',
        theme: ThemeData(primarySwatch: Colors.blue),

        // El builder se aplica a TODAS las pantallas
        builder: (context, child) {
          return Scaffold(
            // Fondo morado para toda la app
            backgroundColor: const Color(0xFF4F47C2),

            // Centra el contenido y fija un ancho máximo
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                // child es la pantalla que se esté mostrando (LoginScreen, etc.)
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          );
        },

        // Primera pantalla (puedes cambiar a rutas nombradas si gustas)
        home: const LoginScreen(),
      ),
    );
  }
}
