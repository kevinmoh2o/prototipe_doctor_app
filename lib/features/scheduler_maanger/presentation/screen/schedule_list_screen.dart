/* // lib/features/schedule_manager/presentation/screen/schedule_list_screen.dart

import 'package:doctor_app/core/constants/app_constants.dart';
import 'package:doctor_app/core/data/models/schedule_model.dart';
import 'package:doctor_app/features/scheduler_maanger/presentation/screen/new_schedule_screen.dart';
import 'package:flutter/material.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  // Copiamos la data de prueba
  late List<ScheduleModel> _schedules;

  @override
  void initState() {
    super.initState();
    _schedules = List.from(AppConstants.sampleSchedules);
  }

  void _addNewSchedule(ScheduleModel schedule) {
    setState(() {
      _schedules.add(schedule);
    });
  }

  void _toggleActive(int index) {
    setState(() {
      _schedules[index].isActive = !_schedules[index].isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Horarios"),
      ),
      body: _schedules.isEmpty
          ? const Center(
              child: Text("No hay horarios definidos."),
            )
          : ListView.builder(
              itemCount: _schedules.length,
              itemBuilder: (context, index) {
                final schedule = _schedules[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(
                      Icons.watch_later_outlined,
                      color: schedule.isActive ? Colors.green : Colors.grey,
                    ),
                    title: Text("${schedule.dayOfWeek}  ${schedule.startTime} - ${schedule.endTime}"),
                    subtitle: Text(schedule.isActive ? "Activo" : "Inactivo"),
                    trailing: Switch(
                      value: schedule.isActive,
                      onChanged: (value) => _toggleActive(index),
                    ),
                    // Si deseas implementar edición al tap
                    onTap: () {
                      // Podrías navegar a una pantalla de edición
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navegar a la pantalla para crear un nuevo horario
          final newSchedule = await Navigator.push<ScheduleModel>(
            context,
            MaterialPageRoute(
              builder: (_) => const NewScheduleScreen(),
            ),
          );
          if (newSchedule != null) {
            _addNewSchedule(newSchedule);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
 */
