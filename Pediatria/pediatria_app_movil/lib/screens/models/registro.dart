//import 'package:flutter/src/material/time.dart';

class RegistroPaciente {
  final String nombrePadre;
  final String nombreMadre;
  final DateTime fechaNacimiento;
  final String lugarNacimiento;
  final double peso;
  final double longitud;
  final String telefonoContacto;
  final String emailContacto;
  final String observaciones;
  final String tipoNacimiento;
  final int frecuenciaCardiaca;
  final double temperatura;
  final int presionArterialSistolica;
  final int presionArterialDiastolica;
  final String sexo;

  RegistroPaciente({
    required this.nombrePadre,
    required this.nombreMadre,
    required this.fechaNacimiento,
    required this.lugarNacimiento,
    required this.peso,
    required this.longitud,
    required this.telefonoContacto,
    required this.emailContacto,
    required this.observaciones,
    required this.tipoNacimiento,
    required this.frecuenciaCardiaca,
    required this.temperatura,
    required this.presionArterialSistolica,
    required this.presionArterialDiastolica,
    required this.sexo, 
  });

  Map<String, dynamic> toMap() {
    return {
      'nombrePadre': nombrePadre,
      'nombreMadre': nombreMadre,
      'fechaNacimiento': fechaNacimiento,
      'lugarNacimiento': lugarNacimiento,
      'peso': peso,
      'longitud': longitud,
      'telefonoContacto': telefonoContacto,
      'emailContacto': emailContacto,
      'observaciones': observaciones,
      'tipoNacimiento': tipoNacimiento,
      'frecuenciaCardiaca': frecuenciaCardiaca,
      'temperatura': temperatura,
      'presionArterialSistolica': presionArterialSistolica,
      'presionArterialDiastolica': presionArterialDiastolica,
      'sexo': sexo,
    };
  }
}
