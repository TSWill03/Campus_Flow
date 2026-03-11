import '../entities/internship_record.dart';

abstract interface class InternshipRepository {
  Stream<List<InternshipRecord>> watchInternships({String? academicProfileId});

  Future<List<InternshipRecord>> getAllInternships({String? academicProfileId});

  Future<InternshipRecord?> findById(String id);

  Future<void> saveInternship(InternshipRecord internship);

  Future<void> deleteInternship(String id);
}
