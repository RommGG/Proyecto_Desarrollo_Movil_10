import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase

class GraficaPacientesSexos extends StatefulWidget {
  @override
  _GraficoPacientesState createState() => _GraficoPacientesState();
}

class _GraficoPacientesState extends State<GraficaPacientesSexos> {
  List<BarChartGroupData> _barChartSexosData = [];
  List<BarChartGroupData> _barChartCiudadesData = [];

  // Función para obtener los datos de sexos
  Future<void> _getSexosData() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('pacientes').get();

    int hombres = 0;
    int mujeres = 0;

    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final sexo = data['sexo'];

      if (sexo == 'Masculino') {
        hombres++;
      } else if (sexo == 'Femenino') {
        mujeres++;
      }
    });

    setState(() {
      _barChartSexosData = [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: hombres.toDouble(),
              color: Colors.blue,
              width: 30,
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: mujeres.toDouble(),
              color: Colors.pink,
              width: 30,
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ],
        ),
      ];
    });
  }

  // Función para obtener los datos de ciudades
  Future<void> _getCiudadesData() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('pacientes').get();

    Map<String, int> ciudades = {};

    List<Color> colores = [
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.cyan,
      Colors.teal,
      Colors.indigo,
      Colors.brown
    ];

    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final ciudad = data['lugarNacimiento'];

      if (ciudad != null) {
        if (ciudades.containsKey(ciudad)) {
          ciudades[ciudad] = ciudades[ciudad]! + 1;
        } else {
          ciudades[ciudad] = 1;
        }
      }
    });

    setState(() {
      _barChartCiudadesData = ciudades.entries.map((entry) {
        int ciudadIndex = ciudades.keys.toList().indexOf(entry.key);
        Color ciudadColor = colores[
            ciudadIndex % colores.length]; // Asigna color de forma cíclica

        return BarChartGroupData(
          x: ciudadIndex, // El índice de la ciudad
          barRods: [
            BarChartRodData(
              toY: entry.value.toDouble(),
              color: ciudadColor,
              width: 30,
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ],
        );
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getSexosData();
    _getCiudadesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100], // Azul suave y calmante
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estadisticas',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.blueGrey[900],
                ),
              ),
              
            ],
          ),
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildInfoContainer(
                title: "Graficas",
                content:
                    "Las gráficas permiten visualizar y comparar datos de manera clara, facilitando el análisis de la distribución de pacientes.",
                imagePath: 'lib/assets/images/img5.jpg',
                gradientColors: [Colors.green[50]!, Colors.green[100]!],
              ),
              SizedBox(height: 20),
              // Contenedor de gráfica de sexos
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Distribución de Pacientes por Sexo',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[900]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    _barChartSexosData.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: 300, // Ajusta el tamaño de la gráfica
                            width: double.infinity,
                            child: BarChart(
                              BarChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 1,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey.withOpacity(0.3),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true, reservedSize: 32),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true, reservedSize: 42),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                barGroups: _barChartSexosData,
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    // Texto explicativo para los sexos
                    Text(
                      'Color azul representa a los pacientes masculinos y color rosa a los pacientes femeninos.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.blue, // Color Masculino
                        ),
                        SizedBox(width: 10),
                        Text('Masculino'),
                        SizedBox(width: 20),
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.pink, // Color Femenino
                        ),
                        SizedBox(width: 10),
                        Text('Femenino'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildInfoContainer(
                title: "Importancia",
                content:
                    "Las gráficas facilitan la toma de decisiones, identificando patrones y tendencias en los datos de pacientes de manera rápida y eficiente.",
                imagePath: 'lib/assets/images/img6.jpg',
                gradientColors: [Colors.green[50]!, Colors.green[100]!],
              ),
              SizedBox(height: 20),

              // Contenedor de gráfica de ciudades
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green[50], // Gris claro
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Distribución de Pacientes por Ciudad de Nacimiento',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[900]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    _barChartCiudadesData.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: 300, // Ajusta el tamaño de la gráfica
                            width: double.infinity,
                            child: BarChart(
                              BarChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 1,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey.withOpacity(0.3),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true, reservedSize: 32),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true, reservedSize: 42),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                barGroups: _barChartCiudadesData,
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    // Texto explicativo para las ciudades
                    Text(
                      'Cada barra representa la cantidad de pacientes nacidos en una ciudad específica.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.green, // Color Ciudad 1
                        ),
                        SizedBox(width: 10),
                        Text('Necaxa'),
                        SizedBox(width: 10),
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.blue, // Color Ciudad 2
                        ),
                        SizedBox(width: 10),
                        Text('Huauchinango'),
                        SizedBox(width: 10),
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.blue, // Color Ciudad 2
                        ),
                        SizedBox(width: 10),
                        Text('Xicotepec'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            textAlign: TextAlign.center,
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
