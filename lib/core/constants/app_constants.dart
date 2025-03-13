import 'package:doctor_app/core/data/models/patient_model.dart';
import 'package:doctor_app/core/data/models/schedule_model.dart';
import 'package:doctor_app/core/data/models/schedule_slot_model.dart';

class AppConstants {
  static const List<String> specialties = [
    'Oncología Médica',
    'Hematología',
    'Oncología Pediátrica',
    'Radioterapia',
    'Cirugía Oncológica',
    'Psicooncología',
    'Oncología Ginecológica',
    'Oncología Torácica',
    'Oncología Digestiva',
    'Oncología Urológica',
    'Oncología Dermatológica',
    'Neurooncología',
    'Oncología de Cabeza y Cuello',
    'Oncología Ortopédica',
    'Oncología Integrativa',
    'Cuidados Paliativos Oncológicos',
    'Oncohematología',
    'Inmunooncología',
    'Genética Oncológica',
    'Farmacología Oncológica',
  ];

  static const List<String> genders = ['Masculino', 'Femenino'];

  // Lista de instituciones médicas en Perú
  static const List<String> medicalInstitutionsPeru = [
    'Instituto Nacional de Enfermedades Neoplásicas (INEN)',
    'Hospital Nacional Edgardo Rebagliati Martins',
    'Hospital Nacional Guillermo Almenara Irigoyen',
    'Hospital Nacional Arzobispo Loayza',
    'Hospital Nacional Cayetano Heredia',
    'Hospital de la Solidaridad',
    'Hospital Nacional Hipólito Unanue',
    'Hospital María Auxiliadora',
    'Clínica Internacional',
    'Clínica Ricardo Palma',
    'Clínica San Pablo',
    'Clínica Anglo Americana',
    'Hospital Militar Central',
    'Hospital Central de la Policía Nacional del Perú',
    'Hospital de Emergencias Casimiro Ulloa',
    'Hospital Regional del Cusco',
    'Hospital Regional de Lambayeque',
    'Hospital Regional de Arequipa',
    'Hospital Alberto Sabogal Sologuren',
    'Clínica Delgado',
  ];

// Lista de países
  static const List<String> countries = [
    'Perú',
    'Argentina',
    'Bolivia',
    'Brasil',
    'Chile',
    'Colombia',
    'Ecuador',
    'México',
    'Paraguay',
    'Uruguay',
    'Venezuela',
    'Estados Unidos',
    'España',
    'Francia',
    'Italia',
    'Alemania',
    'Reino Unido',
    'Canadá',
    'Australia',
    'Japón',
    'China',
    'India',
  ];

// Lista de subespecialidades oncológicas
  static const List<String> subSpecialties = [
    'Oncología Médica',
    'Hematología Oncológica',
    'Oncología Pediátrica',
    'Radioterapia Oncológica',
    'Cirugía Oncológica',
    'Oncología Ginecológica',
    'Oncología Torácica',
    'Oncología Digestiva',
    'Oncología Urológica',
    'Oncología Dermatológica',
    'Neurooncología',
    'Oncología de Cabeza y Cuello',
    'Oncología Ortopédica',
    'Oncología Integrativa',
    'Cuidados Paliativos Oncológicos',
    'Oncohematología',
    'Inmunooncología',
    'Genética Oncológica',
    'Farmacología Oncológica',
    'Oncología de Precisión',
    'Psicooncología',
    'Terapia Celular y Genética Oncológica',
    'Oncología Traslacional',
  ];

  static const List<Map<String, String>> daySummaryData = [
    {
      'title': 'Citas Pendientes',
      'count': '3',
    },
    {
      'title': 'En Seguimiento',
      'count': '5',
    },
  ];

  static const List<String> notifications = [
    'Resultado de laboratorio disponible',
    'Mensaje de un paciente',
    'Recordatorio de cita para mañana',
    'Paciente derivado de otro especialista',
  ];

  static const List<Map<String, String>> quickActions = [
    {
      'label': 'Historial Clínico',
      'icon': 'assignment_ind',
    },
    {
      'label': 'Citas',
      'icon': 'date_range',
    },
    {
      'label': 'Recetas',
      'icon': 'receipt_long',
    },
    {
      'label': 'Facturación',
      'icon': 'paid',
    },
  ];

  static final List<PatientModel> samplePatients = [
    PatientModel(
      id: 'P001',
      nombre: 'María',
      apellido: 'Pérez',
      edad: 45,
      genero: 'Femenino',
      diagnosticoActual: 'Cáncer de Mama',
      diagnosticosPrevios: ['Quiste mamario benigno (2018)'],
      tratamientos: ['Quimioterapia (Ciclo 2 de 6)', 'Anastrozol'],
      notasMedicas: [
        'Paciente responde bien al tratamiento inicial.',
        'Próxima cita en 2 semanas.',
      ],
    ),
    PatientModel(
      id: 'P002',
      nombre: 'Carlos',
      apellido: 'González',
      edad: 60,
      genero: 'Masculino',
      diagnosticoActual: 'Cáncer de Próstata',
      diagnosticosPrevios: ['Hiperplasia prostática benigna (2020)'],
      tratamientos: ['Radioterapia', 'Bicalutamida'],
      notasMedicas: [
        'Recomendada dieta baja en grasas.',
        'Seguimiento mensual, revisión de PSA.',
      ],
    ),
    PatientModel(
      id: 'P003',
      nombre: 'Lucía',
      apellido: 'Ramírez',
      edad: 37,
      genero: 'Femenino',
      diagnosticoActual: 'Leucemia Linfoblástica Aguda',
      diagnosticosPrevios: [],
      tratamientos: ['Quimioterapia intensiva', 'Corticoides'],
      notasMedicas: [
        'Ingresada para el segundo ciclo de quimioterapia.',
        'Monitorizar recuento de células sanguíneas.',
      ],
    ),
  ];

  static final List<ScheduleModel> sampleSchedules = [
    ScheduleModel(
      dayOfWeek: "Lunes",
      startTime: "09:00",
      endTime: "12:00",
      isActive: true,
    ),
    ScheduleModel(
      dayOfWeek: "Martes",
      startTime: "14:00",
      endTime: "18:00",
      isActive: true,
    ),
    ScheduleModel(
      dayOfWeek: "Jueves",
      startTime: "08:00",
      endTime: "11:00",
      isActive: false,
    ),
  ];

  static final Map<DateTime, List<ScheduleSlotModel>> sampleScheduleSlots = {
    // Para simplificar, creamos 2 días con franjas de ejemplo
    DateTime(2025, 3, 10): [
      ScheduleSlotModel(
        start: DateTime(2025, 3, 10, 9, 0),
        end: DateTime(2025, 3, 10, 12, 0),
        note: "Mañana para consultas generales",
      ),
      ScheduleSlotModel(
        start: DateTime(2025, 3, 10, 14, 0),
        end: DateTime(2025, 3, 10, 16, 0),
        note: "Revisiones oncológicas",
      ),
    ],
    DateTime(2025, 3, 11): [
      ScheduleSlotModel(
        start: DateTime(2025, 3, 11, 10, 0),
        end: DateTime(2025, 3, 11, 13, 0),
        isActive: false,
        note: "Reservado, pero desactivado temporalmente",
      ),
    ],
  };

  static const List<String> securityQuestions = [
    '¿Cuál es el nombre de tu primera mascota?',
    '¿Cuál es el nombre de tu mejor amigo de la infancia?',
    '¿En qué ciudad naciste?',
    '¿Cuál fue tu primera escuela?',
    '¿Cuál es el segundo nombre de tu madre?',
  ];
}
