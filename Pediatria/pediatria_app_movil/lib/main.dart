import 'package:flutter/material.dart';
import 'package:pediatria_app_movil/screens/homeScreen.dart';
import 'package:pediatria_app_movil/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pediatría App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthChecker(), // Comprueba si el usuario está autenticado
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Escucha cambios de autenticación
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()), // Pantalla de carga
          );
        }
        if (snapshot.hasData) {
          return HomeScreen(); // Usuario autenticado, muestra la pantalla principal
        }
        return LoginScreen(); // Usuario no autenticado, muestra la pantalla de login
      },
    );
  }
}
