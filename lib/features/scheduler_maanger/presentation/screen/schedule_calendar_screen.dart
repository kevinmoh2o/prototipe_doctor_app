// lib/features/schedule_manager/presentation/screen/schedule_calendar_screen.dart

import 'package:doctor_app/core/constants/app_constants.dart';
import 'package:doctor_app/core/data/models/schedule_slot_model.dart';
import 'package:doctor_app/features/scheduler_maanger/presentation/screen/new_slot_screen.dart';
import 'package:doctor_app/features/scheduler_maanger/presentation/screen/new_week_slot_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendarScreen extends StatefulWidget {
  const ScheduleCalendarScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleCalendarScreen> createState() => _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  late Map<DateTime, List<ScheduleSlotModel>> _events;
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    // Copiamos la data de prueba
    _events = Map.from(AppConstants.sampleScheduleSlots);
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  // Devuelve la lista de slots de un día determinado
  List<ScheduleSlotModel> _getSlotsForDay(DateTime day) {
    final dateOnly = DateTime(day.year, day.month, day.day);
    return _events[dateOnly] ?? [];
  }

  // Añadir un nuevo slot individual
  void _addSlot(ScheduleSlotModel slot) {
    final dateOnly = DateTime(slot.start.year, slot.start.month, slot.start.day);
    setState(() {
      if (_events[dateOnly] == null) {
        _events[dateOnly] = [];
      }
      _events[dateOnly]!.add(slot);
    });
  }

  // Añadir varios slots (para la programación semanal)
  void _addWeeklySlots(List<ScheduleSlotModel> slots) {
    for (var slot in slots) {
      final dateOnly = DateTime(slot.start.year, slot.start.month, slot.start.day);
      if (_events[dateOnly] == null) {
        _events[dateOnly] = [];
      }
      _events[dateOnly]!.add(slot);
    }
    setState(() {});
  }

  // Eliminar un slot
  void _removeSlot(DateTime date, int index) {
    setState(() {
      _events[date]!.removeAt(index);
      if (_events[date]!.isEmpty) {
        _events.remove(date);
      }
    });
  }

  Future<void> _showCreateSlotOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.calendar_view_day),
                title: const Text("Crear Slot Diario"),
                onTap: () async {
                  Navigator.pop(context);
                  final newSlot = await Navigator.push<ScheduleSlotModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewSlotScreen(selectedDay: _selectedDay!),
                    ),
                  );
                  if (newSlot != null) {
                    _addSlot(newSlot);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_week),
                title: const Text("Crear Slot Semanal"),
                onTap: () async {
                  Navigator.pop(context);
                  final newSlots = await Navigator.push<List<ScheduleSlotModel>>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewWeeklySlotScreen(selectedDay: _selectedDay!),
                    ),
                  );
                  if (newSlots != null && newSlots.isNotEmpty) {
                    _addWeeklySlots(newSlots);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSlots = _getSlotsForDay(_selectedDay!);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario de Disponibilidad"),
      ),
      body: Column(
        children: [
          // Calendario con opción de cambiar el formato (mes, 2 semanas, semana)
          TableCalendar<ScheduleSlotModel>(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) => _getSlotsForDay(day),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Lista de slots del día seleccionado
          Expanded(
            child: selectedSlots.isEmpty
                ? const Center(child: Text("No hay franjas definidas para este día."))
                : ListView.builder(
                    itemCount: selectedSlots.length,
                    itemBuilder: (context, index) {
                      final slot = selectedSlots[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        elevation: 2,
                        child: ListTile(
                          leading: Icon(
                            Icons.watch_later_outlined,
                            color: slot.isActive ? Colors.green : Colors.grey,
                          ),
                          title: Text(
                            "${_formatHour(slot.start)} - ${_formatHour(slot.end)}",
                          ),
                          subtitle: Text(slot.note ?? "Sin notas"),
                          trailing: Switch(
                            value: slot.isActive,
                            onChanged: (val) {
                              setState(() {
                                slot.isActive = val;
                              });
                            },
                          ),
                          onLongPress: () {
                            final dateKey = DateTime(slot.start.year, slot.start.month, slot.start.day);
                            _removeSlot(dateKey, index);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateSlotOptions,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatHour(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}
