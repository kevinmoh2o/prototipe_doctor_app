// lib/features/paciente_manager/presentation/screen/patient_detail_screen.dart

import 'package:doctor_app/core/data/models/patient_model.dart';
import 'package:flutter/material.dart';

class PatientDetailScreen extends StatefulWidget {
  final PatientModel patient;

  const PatientDetailScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _newNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 4 tabs: Datos Personales, Diagnósticos, Tratamientos, Notas/Historial
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _newNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = widget.patient;
    return Scaffold(
      appBar: AppBar(
        title: Text("${patient.nombre} ${patient.apellido}"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Datos"),
            Tab(text: "Diagnósticos"),
            Tab(text: "Tratamientos"),
            Tab(text: "Notas"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDatosPersonales(patient),
          _buildDiagnosticos(patient),
          _buildTratamientos(patient),
          _buildNotasMedicas(patient),
        ],
      ),
    );
  }

  Widget _buildDatosPersonales(PatientModel patient) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _infoRow("Nombre", "${patient.nombre} ${patient.apellido}"),
          const SizedBox(height: 8),
          _infoRow("Edad", "${patient.edad} años"),
          const SizedBox(height: 8),
          _infoRow("Género", patient.genero),
          const SizedBox(height: 8),
          _infoRow("Diagnóstico Actual", patient.diagnosticoActual),
        ],
      ),
    );
  }

  Widget _buildDiagnosticos(PatientModel patient) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Diagnósticos Previos",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          if (patient.diagnosticosPrevios.isEmpty)
            const Text("No hay diagnósticos previos registrados.")
          else
            ...patient.diagnosticosPrevios.map(
              (diag) => ListTile(
                leading: const Icon(Icons.local_hospital),
                title: Text(diag),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTratamientos(PatientModel patient) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tratamientos / Medicamentos",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          if (patient.tratamientos.isEmpty)
            const Text("No hay tratamientos registrados.")
          else
            ...patient.tratamientos.map(
              (trat) => ListTile(
                leading: const Icon(Icons.healing),
                title: Text(trat),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotasMedicas(PatientModel patient) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Notas / Historial Clínico",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Expanded(
            child: patient.notasMedicas.isEmpty
                ? const Text("No hay notas registradas.")
                : ListView.builder(
                    itemCount: patient.notasMedicas.length,
                    itemBuilder: (context, index) {
                      final nota = patient.notasMedicas[index];
                      return ListTile(
                        leading: const Icon(Icons.description),
                        title: Text(nota),
                      );
                    },
                  ),
          ),
          // Botón para añadir nueva nota
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newNoteController,
                  decoration: InputDecoration(
                    labelText: "Agregar nota...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final text = _newNoteController.text.trim();
                  if (text.isNotEmpty) {
                    setState(() {
                      patient.notasMedicas.add(text);
                    });
                    _newNoteController.clear();
                  }
                },
                child: const Text("Añadir"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    );
  }
}
