import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MostrarRegistrosPacienteScreen extends StatefulWidget {
  @override
  _MostrarRegistrosPacienteScreenState createState() =>
      _MostrarRegistrosPacienteScreenState();
}

class _MostrarRegistrosPacienteScreenState
    extends State<MostrarRegistrosPacienteScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? tipoNacimientoSeleccionado;

  // Método para eliminar el paciente
  Future<void> _eliminarPaciente(String id) async {
    try {
      await firestore.collection('pacientes').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Paciente eliminado'),
      ));
    } catch (e) {
      print('Error al eliminar paciente: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar el paciente'),
      ));
    }
  }

  // Método para editar los datos del paciente
  Future<void> _editarPaciente(String id, Map<String, dynamic> data) async {
    TextEditingController nombrePadreController =
        TextEditingController(text: data['nombrePadre']);
    TextEditingController nombreMadreController =
        TextEditingController(text: data['nombreMadre']);
    TextEditingController fechaNacimientoController = TextEditingController(
        text:
            DateFormat('yyyy-MM-dd').format(data['fechaNacimiento'].toDate()));
    TextEditingController lugarNacimientoController =
        TextEditingController(text: data['lugarNacimiento']);
    TextEditingController pesoController =
        TextEditingController(text: data['peso'].toString());
    TextEditingController longitudController =
        TextEditingController(text: data['longitud'].toString());
    TextEditingController telefonoController =
        TextEditingController(text: data['telefonoContacto']);
    TextEditingController emailController =
        TextEditingController(text: data['emailContacto']);
    TextEditingController observacionesController =
        TextEditingController(text: data['observaciones']);
    tipoNacimientoSeleccionado =
        data['tipoNacimiento']; // Se establece el valor actual
    TextEditingController frecuenciaCardiacaController =
        TextEditingController(text: data['frecuenciaCardiaca'].toString());
    TextEditingController temperaturaController =
        TextEditingController(text: data['temperatura'].toString());
    TextEditingController presionArterialSistolicaController =
        TextEditingController(
            text: data['presionArterialSistolica'].toString());
    TextEditingController presionArterialDiastolicaController =
        TextEditingController(
            text: data['presionArterialDiastolica'].toString());
    TextEditingController sexoController =
        TextEditingController(text: data['sexo']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Paciente'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nombrePadreController,
                  decoration: InputDecoration(labelText: 'Nombre del Padre'),
                ),
                TextField(
                  controller: nombreMadreController,
                  decoration: InputDecoration(labelText: 'Nombre de la Madre'),
                ),
                TextField(
                  controller: fechaNacimientoController,
                  decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
                ),
                DropdownButtonFormField<String>(
                  value: lugarNacimientoController.text.isEmpty
                      ? 'Necaxa'
                      : lugarNacimientoController.text,
                  decoration: InputDecoration(labelText: 'Lugar de Nacimiento'),
                  items: ['Necaxa', 'Huauchinango', 'Xicotepec']
                      .map((lugar) => DropdownMenuItem<String>(
                            value: lugar,
                            child: Text(lugar),
                          ))
                      .toList(),
                  onChanged: (valor) {
                    setState(() {
                      lugarNacimientoController.text = valor ?? '';
                    });
                  },
                ),
                TextField(
                  controller: pesoController,
                  decoration: InputDecoration(labelText: 'Peso'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: longitudController,
                  decoration: InputDecoration(labelText: 'Longitud'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: telefonoController,
                  decoration:
                      InputDecoration(labelText: 'Teléfono de Contacto'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email de Contacto'),
                ),
                TextField(
                  controller: observacionesController,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                ),
                // Dropdown para el tipo de nacimiento
                DropdownButtonFormField<String>(
                  value: tipoNacimientoSeleccionado ?? 'Normal',
                  decoration: InputDecoration(labelText: 'Tipo de Nacimiento'),
                  items: ['Normal', 'Cesárea']
                      .map((tipo) => DropdownMenuItem<String>(
                            value: tipo,
                            child: Text(tipo),
                          ))
                      .toList(),
                  onChanged: (valor) {
                    setState(() {
                      tipoNacimientoSeleccionado = valor;
                    });
                  },
                ),
                TextField(
                  controller: frecuenciaCardiacaController,
                  decoration: InputDecoration(labelText: 'Frecuencia Cardiaca'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: temperaturaController,
                  decoration: InputDecoration(labelText: 'Temperatura'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: presionArterialSistolicaController,
                  decoration:
                      InputDecoration(labelText: 'Presión Arterial Sistólica'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: presionArterialDiastolicaController,
                  decoration:
                      InputDecoration(labelText: 'Presión Arterial Diastólica'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: sexoController.text.isEmpty
                      ? 'Masculino'
                      : sexoController.text,
                  decoration: InputDecoration(labelText: 'Sexo'),
                  items: ['Masculino', 'Femenino']
                      .map((sexo) => DropdownMenuItem<String>(
                            value: sexo,
                            child: Text(sexo),
                          ))
                      .toList(),
                  onChanged: (valor) {
                    setState(() {
                      sexoController.text = valor ?? '';
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await firestore.collection('pacientes').doc(id).update({
                    'nombrePadre': nombrePadreController.text,
                    'nombreMadre': nombreMadreController.text,
                    'fechaNacimiento':
                        DateTime.parse(fechaNacimientoController.text),
                    'lugarNacimiento': lugarNacimientoController.text,
                    'peso': double.parse(pesoController.text),
                    'longitud': double.parse(longitudController.text),
                    'telefonoContacto': telefonoController.text,
                    'emailContacto': emailController.text,
                    'observaciones': observacionesController.text,
                    'tipoNacimiento': tipoNacimientoSeleccionado ?? '',
                    'frecuenciaCardiaca':
                        int.parse(frecuenciaCardiacaController.text),
                    'temperatura': double.parse(temperaturaController.text),
                    'presionArterialSistolica':
                        int.parse(presionArterialSistolicaController.text),
                    'presionArterialDiastolica':
                        int.parse(presionArterialDiastolicaController.text),
                    'sexo': sexoController.text ?? '',
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Paciente actualizado'),
                  ));
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error al actualizar paciente: $e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error al actualizar el paciente'),
                  ));
                }
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
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
                'Seguimientos',
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
      
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('pacientes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los datos.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay registros disponibles.'));
          }

          final pacientes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: pacientes.length,
            itemBuilder: (context, index) {
              final document = pacientes[index];
              final data = document.data() as Map<String, dynamic>;

              return Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  title: Text(
                    'Nombre del Padre: ${data['nombrePadre']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    'Fecha de Nacimiento: ${DateFormat('dd/MM/yyyy').format(data['fechaNacimiento'].toDate())}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editarPaciente(document.id, data);
                        },
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _eliminarPaciente(document.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
