// lib/core/data/models/patient_model.dart

class PatientModel {
  final String id;
  final String nombre;
  final String apellido;
  final int edad;
  final String genero;

  /// Diagnóstico principal o actual
  final String diagnosticoActual;

  /// Lista de diagnósticos previos
  final List<String> diagnosticosPrevios;

  /// Lista de tratamientos/medicamentos actuales
  final List<String> tratamientos;

  /// Notas médicas, evolución, comentarios, etc.
  final List<String> notasMedicas;

  PatientModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.genero,
    required this.diagnosticoActual,
    required this.diagnosticosPrevios,
    required this.tratamientos,
    required this.notasMedicas,
  });
}
