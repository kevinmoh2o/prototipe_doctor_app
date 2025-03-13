// lib/features/schedule_manager/presentation/screen/new_slot_screen.dart

import 'package:doctor_app/core/data/models/schedule_slot_model.dart';
import 'package:flutter/material.dart';

class NewSlotScreen extends StatefulWidget {
  final DateTime selectedDay;

  const NewSlotScreen({Key? key, required this.selectedDay}) : super(key: key);

  @override
  State<NewSlotScreen> createState() => _NewSlotScreenState();
}

class _NewSlotScreenState extends State<NewSlotScreen> {
  final _formKey = GlobalKey<FormState>();

  late DateTime _startDateTime;
  late DateTime _endDateTime;
  bool _isActive = true;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Por defecto, 09:00 - 12:00 en el día seleccionado
    _startDateTime = DateTime(widget.selectedDay.year, widget.selectedDay.month, widget.selectedDay.day, 9, 0);
    _endDateTime = DateTime(widget.selectedDay.year, widget.selectedDay.month, widget.selectedDay.day, 12, 0);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool isStart) async {
    final initialTime = TimeOfDay(
      hour: isStart ? _startDateTime.hour : _endDateTime.hour,
      minute: isStart ? _startDateTime.minute : _endDateTime.minute,
    );
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDateTime = DateTime(
            _startDateTime.year,
            _startDateTime.month,
            _startDateTime.day,
            picked.hour,
            picked.minute,
          );
        } else {
          _endDateTime = DateTime(
            _endDateTime.year,
            _endDateTime.month,
            _endDateTime.day,
            picked.hour,
            picked.minute,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateString =
        "${widget.selectedDay.day.toString().padLeft(2, '0')}/${widget.selectedDay.month.toString().padLeft(2, '0')}/${widget.selectedDay.year}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Disponibilidad"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Fecha
              Text(
                "Fecha seleccionada: $dateString",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              // Hora de inicio
              TextFormField(
                readOnly: true,
                decoration: _buildDecoration("Hora de Inicio"),
                controller: TextEditingController(text: _formatHour(_startDateTime)),
                onTap: () => _pickTime(true),
                validator: (value) => (value == null || value.isEmpty) ? "Seleccione una hora de inicio" : null,
              ),
              const SizedBox(height: 16),

              // Hora de fin
              TextFormField(
                readOnly: true,
                decoration: _buildDecoration("Hora de Fin"),
                controller: TextEditingController(text: _formatHour(_endDateTime)),
                onTap: () => _pickTime(false),
                validator: (value) => (value == null || value.isEmpty) ? "Seleccione una hora de fin" : null,
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
                onPressed: _saveSlot,
                icon: const Icon(Icons.save),
                label: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSlot() {
    if (_formKey.currentState!.validate()) {
      // Validamos que la hora de inicio sea anterior a la de fin
      if (_endDateTime.isBefore(_startDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("La hora de fin debe ser posterior a la de inicio")),
        );
        return;
      }

      final newSlot = ScheduleSlotModel(
        start: _startDateTime,
        end: _endDateTime,
        isActive: _isActive,
        note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      );

      Navigator.pop(context, newSlot);
    }
  }

  String _formatHour(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
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
