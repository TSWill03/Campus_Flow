// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../data/repositories/drift_academic_profile_repository.dart';
import '../../domain/entities/academic_profile.dart';
import '../../domain/repositories/academic_profile_repository.dart';

final academicProfileRepositoryProvider = Provider<AcademicProfileRepository>(
  (ref) => DriftAcademicProfileRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncQueueServiceProvider),
  ),
);

final academicProfilesProvider = StreamProvider<List<AcademicProfile>>(
  (ref) => ref.watch(academicProfileRepositoryProvider).watchProfiles(),
);

final activeAcademicProfileProvider = StreamProvider<AcademicProfile?>(
  (ref) => ref.watch(academicProfileRepositoryProvider).watchActiveProfile(),
);

final academicProfileByIdProvider =
    FutureProvider.family<AcademicProfile?, String>((ref, id) {
  return ref.watch(academicProfileRepositoryProvider).findById(id);
});
