import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../data/repositories/drift_dashboard_repository.dart';
import '../../domain/entities/attachment_deadline_reminder.dart';
import '../../domain/entities/dashboard_summary.dart';

final dashboardRepositoryProvider = Provider<DriftDashboardRepository>(
  (ref) => DriftDashboardRepository(ref.watch(appDatabaseProvider)),
);

final dashboardSummaryProvider = StreamProvider<DashboardSummary>((ref) {
  final activeProfileId = ref.watch(activeAcademicProfileProvider).valueOrNull?.id;
  return ref
      .watch(dashboardRepositoryProvider)
      .watchSummary(academicProfileId: activeProfileId);
});

final dashboardAttachmentRemindersProvider =
    StreamProvider<List<AttachmentDeadlineReminder>>((ref) {
  final activeProfileId = ref.watch(activeAcademicProfileProvider).valueOrNull?.id;
  return ref
      .watch(dashboardRepositoryProvider)
      .watchPendingAttachmentDeadlines(academicProfileId: activeProfileId);
});
