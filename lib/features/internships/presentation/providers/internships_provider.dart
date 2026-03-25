// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../data/repositories/drift_internship_repository.dart';
import '../../domain/entities/internship_record.dart';
import '../../domain/repositories/internship_repository.dart';

final internshipRepositoryProvider = Provider<InternshipRepository>(
  (ref) => DriftInternshipRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncQueueServiceProvider),
  ),
);

final internshipsProvider = StreamProvider<List<InternshipRecord>>((ref) {
  final activeProfileId = ref
      .watch(activeAcademicProfileProvider)
      .valueOrNull
      ?.id;
  if (activeProfileId == null || activeProfileId.isEmpty) {
    return Stream.value(const <InternshipRecord>[]);
  }
  return ref
      .watch(internshipRepositoryProvider)
      .watchInternships(academicProfileId: activeProfileId);
});

final internshipByIdProvider = FutureProvider.family<InternshipRecord?, String>(
  (ref, id) {
    return ref.watch(internshipRepositoryProvider).findById(id);
  },
);
