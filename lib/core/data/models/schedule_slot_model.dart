// lib/core/data/models/schedule_slot_model.dart

class ScheduleSlotModel {
  final DateTime start;
  final DateTime end;
  bool isActive;
  final String? note;

  ScheduleSlotModel({
    required this.start,
    required this.end,
    this.isActive = true,
    this.note,
  });
}
