import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Método para iniciar sesión con Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Inicia sesión con Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inicio de sesión con Google cancelado.')),
        );
        return;
      }
      //obtiene las credenciales de autenticación del usuario que se ha autenticado a través de Google.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication; //
      //se crean las credenciales necesarias para Firebase 
      //Authentication utilizando el proveedor de Google (GoogleAuthProvider).
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Usa el token de Google para iniciar sesión en Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
      //Mensaje de aceso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inicio de sesión con Google exitoso.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión con Google: $e')), //mensaje de error
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo de la imagen
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/fondo_doc.jpg', // Asegúrate de tener esta imagen
              fit: BoxFit.cover,
            ),
          ),
          // Contenedor de los campos de login con fondo transparente
          Center(
            child: Container(
              width: 350,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Fondo blanco con transparencia
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título
                  Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0D47A1), // Color destacado
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo de email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo de contraseña
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botón de login con email
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Inicio de sesión exitoso')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al iniciar sesión: $e')),
                        );
                      }
                    },
                    child: Text('Login con Email'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue[900],
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botón de login con Google
                  ElevatedButton.icon(
                    onPressed: () => signInWithGoogle(context),
                    
                    label: Text('Login con Google'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color(0xFFF44336),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
