import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navega a la pantalla de login después de 3 segundos.
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor, // Color de fondo según el tema.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen local
            Image.asset(
              'lib/assets/images/LogoHospital.png', // Ruta de la imagen local
              width: 150,               // Ajusta el tamaño de la imagen.
              height: 150,
              fit: BoxFit.contain,      // Mantén la proporción de la imagen.
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            const CircularProgressIndicator(color: Color.fromARGB(255, 82, 76, 76)),
          ],
        ),
      ),
    );
  }
}
