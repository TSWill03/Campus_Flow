// Signature: dev.tswicolly03

import '../entities/complementary_activity.dart';

abstract interface class ComplementaryActivityRepository {
  Stream<List<ComplementaryActivity>> watchActivities({String? academicProfileId});

  Future<List<ComplementaryActivity>> getAllActivities({String? academicProfileId});

  Future<ComplementaryActivity?> findById(String id);

  Future<void> saveActivity(ComplementaryActivity activity);

  Future<void> deleteActivity(String id);
}
