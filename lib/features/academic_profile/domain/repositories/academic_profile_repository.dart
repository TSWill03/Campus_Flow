// Signature: dev.tswicolly03

import '../entities/academic_profile.dart';

abstract interface class AcademicProfileRepository {
  Stream<List<AcademicProfile>> watchProfiles();

  Stream<AcademicProfile?> watchActiveProfile();

  Future<AcademicProfile?> getActiveProfile();

  Future<AcademicProfile?> findById(String id);

  Future<void> saveProfile(AcademicProfile profile);

  Future<void> setActiveProfile(String id);

  Future<void> deleteProfile(String id);

  Future<List<AcademicProfile>> getAllProfiles();
}
