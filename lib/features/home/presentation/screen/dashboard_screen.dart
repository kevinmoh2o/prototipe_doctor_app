import 'package:doctor_app/features/auth/presentation/screen/login_screen.dart';
import 'package:doctor_app/features/home/presentation/widget/dashboard_summary_card.dart';
import 'package:doctor_app/features/paciente_manager/presentation/screen/patient_list_screen.dart';
import 'package:doctor_app/features/scheduler_maanger/presentation/screen/schedule_calendar_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  // Valores de ejemplo para la demostración
  final int patientCount = 124;
  final int upcomingAppointments = 3;
  final int unreadMessages = 5;
  final int reservations = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Lógica para refrescar la información
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mensaje de bienvenida
              Text(
                "Bienvenido, Dr. John Doe",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              // Tarjetas resumen en Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  DashboardSummaryCard(
                    icon: Icons.people,
                    title: "Pacientes",
                    subtitle: "$patientCount registrados",
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PatientListScreen(),
                        ),
                      );
                    },
                  ),
                  DashboardSummaryCard(
                    icon: Icons.calendar_today,
                    title: "Próximas Citas",
                    subtitle: "$upcomingAppointments hoy",
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ScheduleCalendarScreen(),
                        ),
                      );
                    },
                  ),
                  DashboardSummaryCard(
                    icon: Icons.message,
                    title: "Mensajes",
                    subtitle: "$unreadMessages sin leer",
                    color: Colors.green,
                    onTap: () {
                      // Aquí se debe navegar a la pantalla de mensajes
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Navegar a Mensajes")),
                      );
                    },
                  ),
                  DashboardSummaryCard(
                    icon: Icons.bookmark,
                    title: "Reservas",
                    subtitle: "$reservations pendientes",
                    color: Colors.purple,
                    onTap: () {
                      // Aquí se debe navegar a la pantalla de reservas
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Navegar a Reservas")),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Sección adicional para próximas reuniones o citas
              Text(
                "Próximas Reuniones",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildUpcomingMeetingsList(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para crear una nueva cita o reunión
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Crear nueva cita")),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// Lista de próximas reuniones (datos de ejemplo)
  Widget _buildUpcomingMeetingsList(BuildContext context) {
    final meetings = [
      {"time": "10:00 AM", "subject": "Consulta General", "location": "Sala 101"},
      {"time": "11:30 AM", "subject": "Revisión de Resultados", "location": "Sala 203"},
      {"time": "02:00 PM", "subject": "Consulta Especializada", "location": "Sala 305"},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meetings.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final meeting = meetings[index];
        return ListTile(
          leading: const Icon(Icons.access_time),
          title: Text("${meeting['time']} - ${meeting['subject']}"),
          subtitle: Text(meeting['location']!),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navegar a los detalles de la reunión (si se tiene esa pantalla)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Detalles de la reunión")),
            );
          },
        );
      },
    );
  }

  /// Drawer con navegación a las secciones clave de la app
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Dr. John Doe"),
              accountEmail: Text("dr.johndoe@hospital.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuraciones"),
              onTap: () {
                Navigator.pop(context);
                // Aquí se debe navegar a la pantalla de configuraciones
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Navegar a Configuraciones")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_shared),
              title: const Text("Gestión de Pacientes"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PatientListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Gestión de Citas"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ScheduleCalendarScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Cerrar Sesión"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// BottomAppBar con navegación rápida entre secciones
  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Se encuentra en el Home, no hace nada
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ScheduleCalendarScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Navegar a Mensajes")),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Navegar a Perfil")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
