class Doctor {
  final String id;
  final String name;
  final int age;
  final String specialty;
  final List<String> accreditations;
  final List<String> achievements;
  final double rating;

  // Campos extra
  final String email;
  final String phone;
  final int yearsOfExperience;
  final String hospitalAffiliation;
  final String bio;
  final String gender;

  Doctor({
    required this.id,
    required this.name,
    required this.age,
    required this.specialty,
    this.accreditations = const [],
    this.achievements = const [],
    this.rating = 0.0,
    required this.email,
    required this.phone,
    required this.yearsOfExperience,
    required this.hospitalAffiliation,
    required this.bio,
    required this.gender,
  });
}
