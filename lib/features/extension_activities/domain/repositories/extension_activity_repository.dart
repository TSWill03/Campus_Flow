// Signature: dev.tswicolly03

import '../entities/extension_activity.dart';

abstract interface class ExtensionActivityRepository {
  Stream<List<ExtensionActivity>> watchActivities({String? academicProfileId});

  Future<List<ExtensionActivity>> getAllActivities({String? academicProfileId});

  Future<ExtensionActivity?> findById(String id);

  Future<void> saveActivity(ExtensionActivity activity);

  Future<void> deleteActivity(String id);
}
