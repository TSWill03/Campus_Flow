import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../data/repositories/drift_extension_activity_repository.dart';
import '../../domain/entities/extension_activity.dart';
import '../../domain/repositories/extension_activity_repository.dart';

final extensionActivityRepositoryProvider =
    Provider<ExtensionActivityRepository>(
  (ref) => DriftExtensionActivityRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncQueueServiceProvider),
  ),
);

final extensionActivitiesProvider = StreamProvider<List<ExtensionActivity>>(
  (ref) {
    final activeProfileId =
        ref.watch(activeAcademicProfileProvider).valueOrNull?.id;
    return ref
        .watch(extensionActivityRepositoryProvider)
        .watchActivities(academicProfileId: activeProfileId);
  },
);

final extensionActivityByIdProvider =
    FutureProvider.family<ExtensionActivity?, String>((ref, id) {
  return ref.watch(extensionActivityRepositoryProvider).findById(id);
});
