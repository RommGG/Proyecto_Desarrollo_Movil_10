import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './models/registro.dart'; // Asegúrate de tener este archivo del modelo

class RegistroPacienteScreen extends StatefulWidget {
  @override
  _RegistroPacienteScreenState createState() => _RegistroPacienteScreenState();
}

class _RegistroPacienteScreenState extends State<RegistroPacienteScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de entrada
  final TextEditingController _nombrePadreController = TextEditingController();
  final TextEditingController _nombreMadreController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _longitudController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _observacionesController = TextEditingController();
  final TextEditingController _tipoNacimientoController = TextEditingController();
  final TextEditingController _frecuenciaCardiacaController = TextEditingController();
  final TextEditingController _temperaturaController = TextEditingController();
  final TextEditingController _presionArterialSistolicaController = TextEditingController();
  final TextEditingController _presionArterialDiastolicaController = TextEditingController();

  DateTime? _fechaNacimiento;
  String? _sexo;
  String? _lugarNacimiento;

  Future<void> _selectFechaNacimiento(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _fechaNacimiento = picked;
      });
    }
  }

  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_fechaNacimiento == null || _sexo == null || _lugarNacimiento == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Por favor, completa todos los campos obligatorios")),
        );
        return;
      }

      final paciente = RegistroPaciente(
        fechaNacimiento: _fechaNacimiento!,
        lugarNacimiento: _lugarNacimiento!,
        peso: double.parse(_pesoController.text),
        longitud: double.parse(_longitudController.text),
        nombrePadre: _nombrePadreController.text,
        nombreMadre: _nombreMadreController.text,
        telefonoContacto: _telefonoController.text,
        emailContacto: _emailController.text,
        observaciones: _observacionesController.text,
        tipoNacimiento: _tipoNacimientoController.text,
        frecuenciaCardiaca: int.parse(_frecuenciaCardiacaController.text),
        temperatura: double.parse(_temperaturaController.text),
        presionArterialSistolica: int.parse(_presionArterialSistolicaController.text),
        presionArterialDiastolica: int.parse(_presionArterialDiastolicaController.text),
        sexo: _sexo!,
      );

      try {
        await FirebaseFirestore.instance.collection('pacientes').add(paciente.toMap());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Paciente registrado con éxito!")));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al registrar el paciente: $e")));
      }
    }
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
                'Registros',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildTextField("Nombre del Padre", _nombrePadreController),
                _buildTextField("Nombre de la Madre", _nombreMadreController),
                _buildDropdown(
                  "Lugar de Nacimiento",
                  ['Necaxa', 'Huauchinango', 'Xicotepec'],
                  _lugarNacimiento,
                  (value) => setState(() => _lugarNacimiento = value),
                ),
                _buildDropdown(
                  "Sexo del Bebé",
                  ['Masculino', 'Femenino'],
                  _sexo,
                  (value) => setState(() => _sexo = value),
                ),
                _buildTextField("Peso del Bebé (kg)", _pesoController, keyboardType: TextInputType.number),
                _buildTextField("Longitud del Bebé (cm)", _longitudController, keyboardType: TextInputType.number),
                _buildTextField("Teléfono de Contacto", _telefonoController, keyboardType: TextInputType.phone),
                _buildTextField("Email de Contacto", _emailController, keyboardType: TextInputType.emailAddress),
                _buildTextField("Observaciones", _observacionesController),
                _buildDropdown(
                  "Tipo de Nacimiento",
                  ['Normal', 'Cesárea'],
                  _tipoNacimientoController.text.isEmpty ? null : _tipoNacimientoController.text,
                  (value) => setState(() => _tipoNacimientoController.text = value!),
                ),
                _buildTextField("Frecuencia Cardiaca", _frecuenciaCardiacaController, keyboardType: TextInputType.number),
                _buildTextField("Temperatura", _temperaturaController, keyboardType: TextInputType.number),
                _buildTextField("Presión Arterial Sistólica", _presionArterialSistolicaController, keyboardType: TextInputType.number),
                _buildTextField("Presión Arterial Diastólica", _presionArterialDiastolicaController, keyboardType: TextInputType.number),
                _buildDatePicker("Fecha de Nacimiento", _fechaNacimiento, () => _selectFechaNacimiento(context)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  ),
                  child: Text("Registrar Paciente", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
        validator: (value) => value == null || value.isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          fillColor: Colors.grey[100],
          suffixIcon: Icon(Icons.calendar_today),
        ),
        controller: TextEditingController(
          text: date == null ? '' : '${date.toLocal()}'.split(' ')[0],
        ),
        onTap: onTap,
        validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }
}
