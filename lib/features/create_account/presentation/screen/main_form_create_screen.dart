import 'package:doctor_app/core/constants/app_constants.dart';
import 'package:doctor_app/features/create_account/presentation/widgets/searchable_dropdown_field.dart';
import 'package:flutter/material.dart';

// IMPORTA TU "SearchableDropdownField"
// IMPORTA TUS CONSTANTES

class MainFormCreateScreen extends StatefulWidget {
  const MainFormCreateScreen({Key? key}) : super(key: key);

  @override
  _MainFormCreateScreenState createState() => _MainFormCreateScreenState();
}

class _MainFormCreateScreenState extends State<MainFormCreateScreen> {
  // Controladores
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _experienceController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _bioController = TextEditingController();
  final _genderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specialtyController.dispose();
    _experienceController.dispose();
    _hospitalController.dispose();
    _bioController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Crear objeto Doctor y guardar en backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada con éxito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta (Oncólogo)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  hintText: 'Ej: Dr. Juan Pérez',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Edad
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  hintText: 'Ej: 45',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa tu edad';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'Edad no válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Ej: doctor@ejemplo.com',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa tu email';
                  }
                  if (!value.contains('@')) {
                    return 'Email no válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Teléfono
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  hintText: 'Ej: +1 234 567 890',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa tu teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Especialidad (SearchableDropdownField)
              SearchableDropdownField(
                label: 'Especialidad',
                controller: _specialtyController,
                items: AppConstants.specialties,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Selecciona tu especialidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Años de experiencia
              TextFormField(
                controller: _experienceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Años de experiencia',
                  hintText: 'Ej: 10',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa tus años de experiencia';
                  }
                  final exp = int.tryParse(value);
                  if (exp == null || exp < 0) {
                    return 'Valor no válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Hospital
              TextFormField(
                controller: _hospitalController,
                decoration: const InputDecoration(
                  labelText: 'Hospital/Clínica',
                  hintText: 'Ej: Hospital General',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa tu hospital o clínica';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Género (SearchableDropdownField)
              SearchableDropdownField(
                label: 'Género',
                controller: _genderController,
                items: AppConstants.genders,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Selecciona tu género';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Breve Bio
              TextFormField(
                controller: _bioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Breve descripción',
                  hintText: 'Ej: Especialista en oncología con 10 años de experiencia...',
                ),
              ),
              const SizedBox(height: 16),

              // Botón "Crear cuenta"
              ElevatedButton(
                onPressed: _createAccount,
                child: const Text('Crear cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
