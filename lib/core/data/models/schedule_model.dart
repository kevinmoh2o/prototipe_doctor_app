// lib/core/data/models/schedule_model.dart

class ScheduleModel {
  final String dayOfWeek; // Ej: "Lunes"
  final String startTime; // Ej: "09:00"
  final String endTime; // Ej: "12:00"
  bool isActive; // Para habilitar/deshabilitar el horario

  ScheduleModel({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isActive = true,
  });
}
