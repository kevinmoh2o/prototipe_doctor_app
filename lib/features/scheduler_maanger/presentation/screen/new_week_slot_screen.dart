import 'package:doctor_app/core/data/models/schedule_slot_model.dart';
import 'package:flutter/material.dart';

class NewWeeklySlotScreen extends StatefulWidget {
  /// Se usa la fecha seleccionada para determinar el inicio del rango.
  final DateTime selectedDay;

  const NewWeeklySlotScreen({Key? key, required this.selectedDay}) : super(key: key);

  @override
  State<NewWeeklySlotScreen> createState() => _NewWeeklySlotScreenState();
}

class _NewWeeklySlotScreenState extends State<NewWeeklySlotScreen> {
  final _formKey = GlobalKey<FormState>();

  // Para rango semanal, definimos dos fechas (inicio y fin).
  late DateTime _startDate;
  late DateTime _endDate;

  // Para el horario diario en el rango.
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  bool _isActive = true;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Por defecto, la programación semanal abarca 5 días (de lunes a viernes)
    _startDate = widget.selectedDay;
    _endDate = widget.selectedDay.add(const Duration(days: 4));
    _startTime = const TimeOfDay(hour: 9, minute: 0);
    _endTime = const TimeOfDay(hour: 12, minute: 0);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initialDate = isStart ? _startDate : _endDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          // Si la fecha de inicio se selecciona después de la fecha final, ajustar.
          if (_startDate.isAfter(_endDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _startDate = _endDate.subtract(const Duration(days: 1));
          }
        }
      });
    }
  }

  Future<void> _pickTime({required bool isStart}) async {
    final initialTime = isStart ? _startTime : _endTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final startDateString = "${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year}";
    final endDateString = "${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Programación Semanal"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Selección de rango de fechas
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: _buildDecoration("Inicio"),
                      controller: TextEditingController(text: startDateString),
                      onTap: () => _pickDate(isStart: true),
                      validator: (value) => (value == null || value.isEmpty) ? "Seleccione la fecha de inicio" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: _buildDecoration("Fin"),
                      controller: TextEditingController(text: endDateString),
                      onTap: () => _pickDate(isStart: false),
                      validator: (value) => (value == null || value.isEmpty) ? "Seleccione la fecha de fin" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Hora de inicio diaria
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: _buildDecoration("Hora de Inicio"),
                      controller: TextEditingController(text: _formatTime(_startTime)),
                      onTap: () => _pickTime(isStart: true),
                      validator: (value) => (value == null || value.isEmpty) ? "Seleccione la hora de inicio" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: _buildDecoration("Hora de Fin"),
                      controller: TextEditingController(text: _formatTime(_endTime)),
                      onTap: () => _pickTime(isStart: false),
                      validator: (value) => (value == null || value.isEmpty) ? "Seleccione la hora de fin" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Nota
              TextFormField(
                controller: _noteController,
                decoration: _buildDecoration("Notas (opcional)"),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              // Activo / Inactivo
              SwitchListTile(
                title: const Text("Programación Activa"),
                value: _isActive,
                onChanged: (val) {
                  setState(() {
                    _isActive = val;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Botón Guardar
              ElevatedButton.icon(
                onPressed: _saveWeeklySlot,
                icon: const Icon(Icons.save),
                label: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveWeeklySlot() {
    if (_formKey.currentState!.validate()) {
      // Validamos que la hora de fin sea posterior a la de inicio (para cada día)
      final startMinutes = _startTime.hour * 60 + _startTime.minute;
      final endMinutes = _endTime.hour * 60 + _endTime.minute;
      if (endMinutes <= startMinutes) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("La hora de fin debe ser posterior a la de inicio")),
        );
        return;
      }

      // Generar slots para cada día del rango seleccionado
      final List<ScheduleSlotModel> slots = [];
      for (DateTime day = _startDate; !day.isAfter(_endDate); day = day.add(const Duration(days: 1))) {
        final slotStart = DateTime(day.year, day.month, day.day, _startTime.hour, _startTime.minute);
        final slotEnd = DateTime(day.year, day.month, day.day, _endTime.hour, _endTime.minute);
        slots.add(ScheduleSlotModel(
          start: slotStart,
          end: slotEnd,
          isActive: _isActive,
          note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        ));
      }

      Navigator.pop(context, slots);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
