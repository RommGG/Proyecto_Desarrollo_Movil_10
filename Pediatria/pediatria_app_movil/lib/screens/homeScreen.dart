import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pediatria_app_movil/screens/grafica_pacientes.dart';
import 'package:pediatria_app_movil/screens/registros.dart';
import 'package:pediatria_app_movil/screens/seguimiento.dart';

class HomeScreen extends StatelessWidget {
  
  void navigateToScreen(String screenName, BuildContext context) {
    switch (screenName) {
      case "Registro":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistroPacienteScreen()),
        );
        break;
      case "Seguimiento":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MostrarRegistrosPacienteScreen()),
        );
        break;
      case "Estadisticas":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GraficaPacientesSexos()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBBDEFB), // Azul suave y calmante
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PrivilegeCare',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.blueGrey[900],
                ),
              ),
              Text(
                'Cuidamos de lo más importante: tus niños',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF546E7A),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.blueGrey[600]),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Fila de botones en lista, uno debajo del otro
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildStylishButton(
                    "Registro", 
                    Icons.person_add, 
                    context,
                  ),
                  SizedBox(height: 15),
                  _buildStylishButton(
                    "Seguimiento", 
                    Icons.search, 
                    context,
                  ),
                  SizedBox(height: 15),
                  _buildStylishButton(
                    "Estadisticas", 
                    Icons.bar_chart, 
                    context,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Información sobre el hospital 
            _buildInfoContainer(
              title: "Sobre nosotros",
              content: "En nuestro hospital, nos especializamos en la atención pediátrica. Brindamos servicios médicos de calidad para el cuidado y bienestar de los niños.",
              imagePath: 'lib/assets/images/doc3.jpg',
              gradientColors: [Colors.green[50]!, Colors.green[100]!],
            ),
            SizedBox(height: 20),
            // Consejos para el cuidado infantil
            _buildInfoContainer(
              title: "Consejos para el cuidado infantil",
              content: "1. Asegúrate de realizar revisiones médicas periódicas.\n2. Mantén una nutrición adecuada y equilibrada para su desarrollo.\n3. Fomenta la actividad física para fortalecer su salud.\n4. Asegúrate de que reciban las vacunas necesarias a tiempo.",
              imagePath: 'lib/assets/images/img1.jpg',
              gradientColors: [Colors.green[50]!, Colors.green[100]!],
            ),
            SizedBox(height: 20),
            // Salud Mental Infantil
            _buildInfoContainer(
              title: "Salud Mental Infantil",
              content: "Es importante reconocer y tratar problemas emocionales en los niños. Fomenta un ambiente positivo y habla con ellos sobre sus emociones.",
              imagePath: 'lib/assets/images/img2.jpg',
              gradientColors: [Colors.green[50]!, Colors.green[100]!],
            ),
            SizedBox(height: 20),

            // Información sobre prevención de enfermedades comunes
            _buildInfoContainer(
              title: "Prevención de Enfermedades Comunes",
              content: "1. Lávate las manos regularmente.\n 2. Mantén al niño alejado de personas enfermas.\n'3. Asegúrate de que se cubra la boca al toser o estornudar",
              imagePath: 'lib/assets/images/img3.jpg',
              gradientColors: [Colors.green[50]!, Colors.green[100]!],
            ),
            SizedBox(height: 20),

            // Consejos sobre el sueño saludable para los niños
            _buildInfoContainer(
              title: "Sueño Saludable Infantil",
              content: "1. Establece una rutina regular para dormir.\n2. Crea un ambiente tranquilo y cómodo en su habitación.\n3. Evita el uso de dispositivos electrónicos antes de dormir.",
              imagePath: 'lib/assets/images/img4.jpg',
              gradientColors: [Colors.green[50]!, Colors.green[100]!],
            ),
            SizedBox(height: 20),

            // Sección de "Contáctenos"
            Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromARGB(255, 116, 172, 204)!, const Color.fromARGB(255, 164, 175, 241)!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Contáctenos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Si necesitas más información o tienes alguna duda, no dudes en contactarnos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Teléfono: +1 (123) 456-7890\nEmail: privilegeCare@hospital.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                  ),

                ],
              ),
              
            ),                    SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildStylishButton(String label, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToScreen(label, context);
      },
      child: Container(
        width: double.infinity, // Hacer el botón ocupar todo el ancho
        height: 60, // Botones con altura moderada
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[200]!, Colors.blue[300]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer({
    required String title,
    required String content,
    required String imagePath,
    required List<Color> gradientColors,
  }) {
    return Container(
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[900],
            ),
          ),
          SizedBox(height: 15),
          Text(
            content,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey[700],
            ),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: 320,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
