import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco para toda la pantalla.
      appBar: AppBar(
        backgroundColor: Colors.white, // Fondo blanco para el AppBar.
        title: const Text(
          'Crea una cuenta',
          style: TextStyle(
            color: Color(0xFF0B8FAC), // Color #0B8FAC para el texto.
            fontWeight: FontWeight.bold, // Negritas para el texto.
          ),
        ),
        centerTitle: true, // Centra el título del AppBar.
        elevation: 0, // Sin sombra para el AppBar.
        iconTheme: const IconThemeData(color: Color(0xFF0B8FAC)), // Iconos del mismo color que el texto.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaciado alrededor del contenido.
        child: SingleChildScrollView( // Permite desplazarse si el contenido es largo.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda.
            children: [
              // Título principal.
              
              const SizedBox(height: 32),
              // Etiqueta "Nombre completo".
              const Text(
                'Nombre completo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  filled: true, // Activa el fondo relleno.
                  fillColor: Colors.grey[200], // Fondo gris claro.
                  hintText: 'Ingresa tu nombre completo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // Sin borde.
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Etiqueta "Correo".
              const Text(
                'Correo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  filled: true, // Activa el fondo relleno.
                  fillColor: Colors.grey[200], // Fondo gris claro.
                  hintText: 'Ingresa tu correo electrónico',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // Sin borde.
                  ),
                ),
                keyboardType: TextInputType.emailAddress, // Teclado de email.
              ),
              const SizedBox(height: 16),
              // Etiqueta "Número de teléfono".
              const Text(
                'Número de teléfono',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  filled: true, // Activa el fondo relleno.
                  fillColor: Colors.grey[200], // Fondo gris claro.
                  hintText: 'Ingresa tu número de teléfono',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // Sin borde.
                  ),
                ),
                keyboardType: TextInputType.phone, // Teclado de números.
              ),
              const SizedBox(height: 16),
              // Etiqueta "Contraseña".
              const Text(
                'Contraseña',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true, // Oculta el texto para contraseñas.
                decoration: InputDecoration(
                  filled: true, // Activa el fondo relleno.
                  fillColor: Colors.grey[200], // Fondo gris claro.
                  hintText: 'Ingresa tu contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // Sin borde.
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Botón para registrarse.
              SizedBox(
                width: double.infinity, // Botón de ancho completo.
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la funcionalidad para el botón.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B8FAC), // Color de fondo #0B8FAC.
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Texto en blanco.
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
