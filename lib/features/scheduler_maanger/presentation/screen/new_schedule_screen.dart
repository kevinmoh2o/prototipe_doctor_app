/* // lib/features/schedule_manager/presentation/screen/new_schedule_screen.dart

import 'package:doctor_app/core/data/models/schedule_model.dart';
import 'package:flutter/material.dart';

class NewScheduleScreen extends StatefulWidget {
  const NewScheduleScreen({Key? key}) : super(key: key);

  @override
  State<NewScheduleScreen> createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends State<NewScheduleScreen> {
  final _formKey = GlobalKey<FormState>();

  // Listado simple de días de la semana
  final List<String> _daysOfWeek = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",
  ];

  String? _selectedDay;
  String _startTime = "09:00";
  String _endTime = "12:00";
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Horario"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Día de la semana
              DropdownButtonFormField<String>(
                value: _selectedDay,
                items: _daysOfWeek.map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
                decoration: _buildDecoration("Día de la semana"),
                onChanged: (value) {
                  setState(() {
                    _selectedDay = value;
                  });
                },
                validator: (value) => value == null ? "Seleccione un día" : null,
              ),
              const SizedBox(height: 16),

              // Hora de inicio
              TextFormField(
                readOnly: true,
                decoration: _buildDecoration("Hora de Inicio"),
                controller: TextEditingController(text: _startTime),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 9, minute: 0),
                  );
                  if (picked != null) {
                    setState(() {
                      _startTime = _formatTime(picked);
                    });
                  }
                },
                validator: (value) => (value == null || value.isEmpty) ? "Seleccione una hora de inicio" : null,
              ),
              const SizedBox(height: 16),

              // Hora de fin
              TextFormField(
                readOnly: true,
                decoration: _buildDecoration("Hora de Fin"),
                controller: TextEditingController(text: _endTime),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 12, minute: 0),
                  );
                  if (picked != null) {
                    setState(() {
                      _endTime = _formatTime(picked);
                    });
                  }
                },
                validator: (value) => (value == null || value.isEmpty) ? "Seleccione una hora de fin" : null,
              ),
              const SizedBox(height: 16),

              // Activo o no
              SwitchListTile(
                title: const Text("Horario Activo"),
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
                onPressed: _saveSchedule,
                icon: const Icon(Icons.save),
                label: const Text("Guardar Horario"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      final newSchedule = ScheduleModel(
        dayOfWeek: _selectedDay!,
        startTime: _startTime,
        endTime: _endTime,
        isActive: _isActive,
      );
      Navigator.pop(context, newSchedule);
    }
  }

  String _formatTime(TimeOfDay time) {
    // Formato HH:mm con 2 dígitos
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
 */
