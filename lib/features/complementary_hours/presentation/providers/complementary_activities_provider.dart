import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../data/repositories/drift_complementary_activity_repository.dart';
import '../../domain/entities/complementary_activity.dart';
import '../../domain/repositories/complementary_activity_repository.dart';

final complementaryActivityRepositoryProvider =
    Provider<ComplementaryActivityRepository>(
  (ref) =>
      DriftComplementaryActivityRepository(
        ref.watch(appDatabaseProvider),
        ref.watch(syncQueueServiceProvider),
      ),
);

final complementaryActivitiesProvider =
    StreamProvider<List<ComplementaryActivity>>(
  (ref) {
    final activeProfileId =
        ref.watch(activeAcademicProfileProvider).valueOrNull?.id;
    return ref
        .watch(complementaryActivityRepositoryProvider)
        .watchActivities(academicProfileId: activeProfileId);
  },
);

final complementaryActivityByIdProvider =
    FutureProvider.family<ComplementaryActivity?, String>((ref, id) {
  return ref.watch(complementaryActivityRepositoryProvider).findById(id);
});
