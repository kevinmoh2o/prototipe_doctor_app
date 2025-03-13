// lib/features/paciente_manager/presentation/screen/patient_list_screen.dart

import 'package:doctor_app/core/constants/app_constants.dart';
import 'package:doctor_app/core/data/models/patient_model.dart';
import 'package:doctor_app/features/paciente_manager/presentation/screen/patient_detail_screen.dart';
import 'package:flutter/material.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<PatientModel> _filteredPatients;

  @override
  void initState() {
    super.initState();
    _filteredPatients = AppConstants.samplePatients;
  }

  void _filterPatients(String query) {
    setState(() {
      _filteredPatients = AppConstants.samplePatients
          .where((p) =>
              p.nombre.toLowerCase().contains(query.toLowerCase()) ||
              p.apellido.toLowerCase().contains(query.toLowerCase()) ||
              p.diagnosticoActual.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Pacientes"),
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterPatients,
              decoration: InputDecoration(
                labelText: "Buscar paciente...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),

          // Lista de pacientes
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPatients.length,
              itemBuilder: (context, index) {
                final patient = _filteredPatients[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text("${patient.nombre} ${patient.apellido}"),
                    subtitle: Text("Diagnóstico: ${patient.diagnosticoActual}"),
                    onTap: () {
                      // Ir a detalle del paciente
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PatientDetailScreen(patient: patient),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
