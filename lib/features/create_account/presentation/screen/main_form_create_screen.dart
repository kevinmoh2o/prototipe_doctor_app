import 'package:doctor_app/core/constants/app_constants.dart';
import 'package:doctor_app/features/create_account/presentation/screen/success_registration_screen.dart';
import 'package:doctor_app/features/create_account/presentation/widgets/searchable_dropdown_field.dart';
import 'package:flutter/material.dart';

class MainFormCreateScreen extends StatefulWidget {
  const MainFormCreateScreen({Key? key}) : super(key: key);

  @override
  _MainFormCreateScreenState createState() => _MainFormCreateScreenState();
}

class _MainFormCreateScreenState extends State<MainFormCreateScreen> {
  int _currentStep = 0;

  /// Creamos una lista de GlobalKey, uno por cada paso.
  final List<GlobalKey<FormState>> _formKeys = List.generate(5, (_) => GlobalKey<FormState>());

  // Etapa 1: Información Personal
  final _nombreController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();
  String? _selectedGenero;
  final _dniController = TextEditingController();

  // Etapa 2: Información de Contacto
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _movilController = TextEditingController();
  final _telefonoAlternativoController = TextEditingController();
  final _direccionController = TextEditingController();

  // Etapa 3: Información Profesional
  final _especialidadController = TextEditingController();
  final _subespecialidadController = TextEditingController();
  String? _selectedExperiencia;
  final _numeroColegiaturaController = TextEditingController();
  final _institucionController = TextEditingController();
  final _paisCiudadController = TextEditingController();

  // Etapa 4: Documentos y Validación
  String? _cedulaPath;
  String? _certificadoPath;
  String? _cartaPresentacionPath;
  bool _firmaConfirmada = false;

  // Etapa 5: Creación de Cuenta y Seguridad
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _respuestaSeguridadController = TextEditingController();
  final _securityQuestionController = TextEditingController();
  bool _consentimiento = false;

  @override
  void dispose() {
    // Liberar controladores
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _fechaNacimientoController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _movilController.dispose();
    _telefonoAlternativoController.dispose();
    _direccionController.dispose();
    _especialidadController.dispose();
    _subespecialidadController.dispose();
    _numeroColegiaturaController.dispose();
    _institucionController.dispose();
    _paisCiudadController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordController.dispose();
    _respuestaSeguridadController.dispose();
    _securityQuestionController.dispose();
    super.dispose();
  }

  void _continue() {
    final isValid = _formKeys[_currentStep].currentState?.validate() ?? false;
    if (!isValid) return;

    if (_currentStep < 4) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      // Navigate to success screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessRegistrationScreen()),
      );
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  Future<void> _selectFechaNacimiento() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _fechaNacimientoController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      });
    }
  }

  // Simulación para selección de archivos
  Future<void> _pickFile(String field) async {
    setState(() {
      if (field == "cedula") {
        _cedulaPath = "path/to/cedula.jpg";
      } else if (field == "certificado") {
        _certificadoPath = "path/to/certificado.jpg";
      } else if (field == "carta") {
        _cartaPresentacionPath = "path/to/carta.jpg";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Especialista"),
      ),
      body: SingleChildScrollView(
        child: Stepper(
          // Usamos Stepper vertical para evitar desbordamientos horizontales
          type: StepperType.vertical,
          physics: const ClampingScrollPhysics(),
          currentStep: _currentStep,
          onStepContinue: _continue,
          onStepCancel: _cancel,
          controlsBuilder: (context, details) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep != 0)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text("Anterior"),
                    ),
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      _currentStep == 4 ? "Finalizar Registro ✅" : "Siguiente →",
                    ),
                  ),
                ],
              ),
            );
          },
          steps: [
            // 1️⃣ Información Personal
            Step(
              title: const Text("Personal"),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
              content: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeys[0], // Clave para el paso 0
                child: _buildStep1Personal(),
              ),
            ),
            // 2️⃣ Información de Contacto
            Step(
              title: const Text("Contacto"),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
              content: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeys[1],
                child: _buildStep2Contacto(),
              ),
            ),
            // 3️⃣ Información Profesional
            Step(
              title: const Text("Profesional"),
              isActive: _currentStep >= 2,
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
              content: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeys[2],
                child: _buildStep3Profesional(),
              ),
            ),
            // 4️⃣ Documentos y Validación
            Step(
              title: const Text("Documentos"),
              isActive: _currentStep >= 3,
              state: _currentStep > 3 ? StepState.complete : StepState.indexed,
              content: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeys[3],
                child: _buildStep4Documentos(),
              ),
            ),
            // 5️⃣ Creación de Cuenta y Seguridad
            Step(
              title: const Text("Cuenta"),
              isActive: _currentStep >= 4,
              state: _currentStep > 4 ? StepState.complete : StepState.indexed,
              content: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeys[4],
                child: _buildStep5Cuenta(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Contenido de cada Step (separado en métodos privados para mayor legibilidad)

  Widget _buildStep1Personal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📌 Objetivo: Capturar datos básicos del especialista."),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nombreController,
          decoration: _buildDecoration("Nombres"),
          validator: (value) => value == null || value.isEmpty ? "Ingrese su(s) nombre(s)" : null,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _apellidoPaternoController,
          decoration: _buildDecoration("Apellido Paterno"),
          validator: (value) => value == null || value.isEmpty ? "Ingrese su apellido paterno" : null,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _apellidoMaternoController,
          decoration: _buildDecoration("Apellido Materno"),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _fechaNacimientoController,
          readOnly: true,
          decoration: _buildDecoration("Fecha de Nacimiento (DD/MM/AAAA) 📅"),
          onTap: _selectFechaNacimiento,
          validator: (value) => value == null || value.isEmpty ? "Seleccione su fecha de nacimiento" : null,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGenero,
          items: ["Masculino", "Femenino"].map((genero) => DropdownMenuItem(value: genero, child: Text(genero))).toList(),
          decoration: _buildDecoration("Género"),
          onChanged: (value) {
            setState(() {
              _selectedGenero = value;
            });
          },
          validator: (value) => value == null ? "Seleccione su género" : null,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _dniController,
          decoration: _buildDecoration("Número de DNI o Cédula Profesional"),
        ),
      ],
    );
  }

  Widget _buildStep2Contacto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📌 Objetivo: Permitir la comunicación con el especialista."),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          decoration: _buildDecoration("Correo Electrónico 📧"),
          validator: (value) {
            if (value == null || value.isEmpty) return "Ingrese su correo";
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Correo inválido";
            return null;
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _confirmEmailController,
          decoration: _buildDecoration("Confirmar Correo Electrónico"),
          validator: (value) => value != _emailController.text ? "Los correos no coinciden" : null,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _movilController,
          decoration: _buildDecoration("Número de Teléfono Móvil 📱"),
          validator: (value) => value == null || value.isEmpty ? "Ingrese su teléfono móvil" : null,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _telefonoAlternativoController,
          decoration: _buildDecoration("Teléfono Alternativo (Opcional)"),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _direccionController,
          decoration: _buildDecoration("Dirección (Ciudad / País)"),
        ),
      ],
    );
  }

  Widget _buildStep3Profesional() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📌 Objetivo: Registrar credenciales médicas verificables."),
        const SizedBox(height: 8),
        SearchableDropdownField(
          label: "Especialidad Principal",
          controller: _especialidadController,
          items: AppConstants.specialties,
        ),
        const SizedBox(height: 8),
        SearchableDropdownField(
          label: "Subespecialidad (Opcional)",
          controller: _subespecialidadController,
          items: AppConstants.subSpecialties,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedExperiencia,
          items: ["1-5 años", "6-10 años", "11+ años"].map((exp) => DropdownMenuItem(value: exp, child: Text(exp))).toList(),
          decoration: _buildDecoration("Años de Experiencia ⏳"),
          onChanged: (value) {
            setState(() {
              _selectedExperiencia = value;
            });
          },
          validator: (value) => value == null ? "Seleccione su experiencia" : null,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _numeroColegiaturaController,
          decoration: _buildDecoration("Número de Colegiatura o Registro Médico 🏥"),
          keyboardType: TextInputType.number,
          validator: (value) => value == null || value.isEmpty ? "Ingrese su número de colegiatura" : null,
        ),
        const SizedBox(height: 8),
        SearchableDropdownField(
          label: "Institución donde Trabaja",
          controller: _institucionController,
          items: AppConstants.medicalInstitutionsPeru,
        ),
        const SizedBox(height: 8),
        SearchableDropdownField(
          label: "País y Ciudad de Ejercicio Profesional",
          controller: _paisCiudadController,
          items: AppConstants.countries,
        ),
      ],
    );
  }

  Widget _buildStep4Documentos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📌 Objetivo: Subir documentos para validar la identidad y profesión."),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _pickFile("cedula"),
          icon: const Icon(Icons.upload_file),
          label: Text(
            _cedulaPath == null ? "Subir Foto de la Cédula Profesional" : "Cédula seleccionada",
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _pickFile("certificado"),
          icon: const Icon(Icons.upload_file),
          label: Text(
            _certificadoPath == null ? "Subir Certificado de Especialidad" : "Certificado seleccionado",
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _pickFile("carta"),
          icon: const Icon(Icons.upload_file),
          label: Text(
            _cartaPresentacionPath == null ? "Subir Carta de Presentación del Hospital" : "Carta seleccionada",
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          title: const Text("Confirmo que la información proporcionada es correcta"),
          value: _firmaConfirmada,
          onChanged: (value) {
            setState(() {
              _firmaConfirmada = value ?? false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildStep5Cuenta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📌 Objetivo: Configurar credenciales para el acceso."),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          decoration: _buildDecoration("Contraseña"),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) return "Ingrese una contraseña";
            if (value.length < 8) return "Debe tener al menos 8 caracteres";
            // Aquí puedes agregar más validaciones (mayúscula, número, símbolo, etc.)
            return null;
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: _buildDecoration("Confirmar Contraseña"),
          obscureText: true,
          validator: (value) => value != _passwordController.text ? "Las contraseñas no coinciden" : null,
        ),
        const SizedBox(height: 8),
        SearchableDropdownField(
          label: "Pregunta de Seguridad",
          controller: _securityQuestionController,
          items: AppConstants.securityQuestions,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _respuestaSeguridadController,
          decoration: _buildDecoration(
            "Respuesta a la pregunta de Seguridad",
            hint: "",
          ),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          title: const Text("Consentimiento y Políticas de Privacidad"),
          value: _consentimiento,
          onChanged: (value) {
            setState(() {
              _consentimiento = value ?? false;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }

  // Helper para InputDecoration
  InputDecoration _buildDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
