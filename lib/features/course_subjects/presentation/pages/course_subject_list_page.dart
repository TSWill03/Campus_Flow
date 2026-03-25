// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_formatters.dart';
import '../../../../core/utils/weekday_labels.dart';
import '../../../academic_profile/domain/entities/academic_profile.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../domain/entities/course_subject.dart';
import '../providers/course_subjects_provider.dart';

class CourseSubjectListPage extends ConsumerWidget {
  const CourseSubjectListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(courseSubjectsProvider);
    final allSubjects =
        ref.watch(allCourseSubjectsProvider).valueOrNull ??
        const <CourseSubject>[];
    final activeProfile = ref.watch(activeAcademicProfileProvider).valueOrNull;
    final profiles =
        ref.watch(academicProfilesProvider).valueOrNull ??
        const <AcademicProfile>[];

    return AsyncValueView<List<CourseSubject>>(
      value: subjectsAsync,
      data: (subjects) {
        final profileNameById = {
          for (final profile in profiles) profile.id: profile.profileName,
        };
        final subjectNameById = {
          for (final subject in allSubjects) subject.id: subject.name,
        };
        final creditSubjects = subjects
            .where(
              (subject) =>
                  subject.creditStatus != CourseSubjectCreditStatus.none,
            )
            .toList();

        return ListView(
          children: [
            SectionHeader(
              title: 'Disciplinas do curso',
              subtitle:
                  'Cadastre materias da graduacao, acompanhe situacao atual e agora mantenha tambem um historico de aulas por disciplina.',
              action: FilledButton.icon(
                onPressed: () => context.push('/subjects/new'),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Nova disciplina'),
              ),
            ),
            const SizedBox(height: 24),
            if (activeProfile == null)
              EmptyStateCard(
                icon: Icons.account_balance_outlined,
                title: 'Selecione um perfil academico',
                message:
                    'As disciplinas agora pertencem a um perfil academico especifico. Crie ou ative um perfil antes de continuar.',
                action: FilledButton(
                  onPressed: () => context.go('/profile'),
                  child: const Text('Gerenciar perfis'),
                ),
              )
            else ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance_rounded),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Perfil ativo: ${activeProfile.profileName}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/profile'),
                        child: const Text('Trocar'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (creditSubjects.isNotEmpty) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aproveitamentos do perfil ativo',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Use esta lista para acompanhar o que ja foi marcado como sugestao, solicitado ou aprovado para levar a coordenacao.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        ...creditSubjects.map(
                          (subject) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _CreditSummaryTile(
                              subject: subject,
                              sourceSubjectName:
                                  subject.creditSourceSubjectId == null
                                  ? null
                                  : subjectNameById[subject
                                        .creditSourceSubjectId],
                              sourceProfileName:
                                  subject.creditSourceProfileId == null
                                  ? null
                                  : profileNameById[subject
                                        .creditSourceProfileId],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (subjects.isEmpty)
                EmptyStateCard(
                  icon: Icons.menu_book_outlined,
                  title: 'Nenhuma disciplina cadastrada',
                  message:
                      'Comece registrando as materias da graduacao para acompanhar o progresso do curso.',
                  action: FilledButton(
                    onPressed: () => context.push('/subjects/new'),
                    child: const Text('Cadastrar disciplina'),
                  ),
                )
              else
                ...subjects.map(
                  (subject) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _CourseSubjectCard(
                      subject: subject,
                      subjectNameById: subjectNameById,
                      profileNameById: profileNameById,
                    ),
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}

class _CourseSubjectCard extends ConsumerWidget {
  const _CourseSubjectCard({
    required this.subject,
    required this.subjectNameById,
    required this.profileNameById,
  });

  final CourseSubject subject;
  final Map<String, String> subjectNameById;
  final Map<String, String> profileNameById;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusColor = _statusColor(context);
    final prerequisiteNames = subject.prerequisiteSubjectIds
        .map((id) => subjectNameById[id])
        .whereType<String>()
        .toList();
    final creditSourceSubjectName = subject.creditSourceSubjectId == null
        ? null
        : subjectNameById[subject.creditSourceSubjectId];
    final creditSourceProfileName = subject.creditSourceProfileId == null
        ? null
        : profileNameById[subject.creditSourceProfileId];

    return Card(
      color: statusColor.withValues(
        alpha: Theme.of(context).brightness == Brightness.dark ? 0.18 : 0.08,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: statusColor.withValues(
            alpha: Theme.of(context).brightness == Brightness.dark
                ? 0.55
                : 0.24,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        subject.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      StatusChip(
                        label: subject.status.label,
                        color: statusColor,
                      ),
                      StatusChip(label: subject.type.label),
                      if (subject.creditStatus !=
                          CourseSubjectCreditStatus.none)
                        StatusChip(
                          label: subject.creditStatus.label,
                          color: _creditStatusColor(context),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    [
                      if (subject.code != null && subject.code!.isNotEmpty)
                        subject.code!,
                      '${subject.workloadHours} h',
                      if (subject.electiveHours != null)
                        '${subject.electiveHours} h optativa',
                      if (subject.suggestedSemester != null)
                        '${subject.suggestedSemester}o periodo',
                      if (subject.scheduledWeekday != null)
                        'Toda ${WeekdayLabels.shortLabel(subject.scheduledWeekday)}',
                      if (subject.defaultLessonHours != null)
                        '${AppFormatters.formatLessonHours(subject.defaultLessonHours!)} por aula',
                    ].join(' - '),
                  ),
                  if (subject.notes != null &&
                      subject.notes!.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(subject.notes!),
                  ],
                  if (subject.creditStatus !=
                      CourseSubjectCreditStatus.none) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_turned_in_rounded,
                          size: 18,
                          color: _creditStatusColor(context),
                        ),
                        Text(
                          [
                            if (creditSourceSubjectName != null)
                              'Origem: $creditSourceSubjectName',
                            if (creditSourceProfileName != null)
                              'Perfil: $creditSourceProfileName',
                            if (subject.creditMatchScore != null)
                              'Compatibilidade ${(subject.creditMatchScore! * 100).round()}%',
                          ].join(' - '),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                  if (prerequisiteNames.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                          color: statusColor,
                        ),
                        Text(
                          'Pre-requisitos: ${prerequisiteNames.join(', ')}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ] else if (subject.prerequisiteSubjectIds.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                          color: statusColor,
                        ),
                        Text(
                          '${subject.prerequisiteSubjectIds.length} pre-requisito(s) vinculado(s)',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            PopupMenuButton<CourseSubjectStatus>(
              tooltip: 'Alterar status',
              onSelected: (status) {
                ref
                    .read(courseSubjectRepositoryProvider)
                    .updateStatus(subject.id, status);
              },
              itemBuilder: (context) => CourseSubjectStatus.values
                  .map(
                    (status) =>
                        PopupMenuItem(value: status, child: Text(status.label)),
                  )
                  .toList(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.sync_alt_rounded),
              ),
            ),
            if (subject.creditStatus != CourseSubjectCreditStatus.none)
              PopupMenuButton<CourseSubjectCreditStatus>(
                tooltip: 'Atualizar aproveitamento',
                onSelected: (creditStatus) async {
                  final nextSubject =
                      creditStatus == CourseSubjectCreditStatus.none
                      ? subject.copyWith(
                          creditSourceSubjectId: null,
                          creditSourceProfileId: null,
                          creditStatus: CourseSubjectCreditStatus.none,
                          creditMatchScore: null,
                        )
                      : subject.copyWith(creditStatus: creditStatus);
                  await ref
                      .read(courseSubjectRepositoryProvider)
                      .saveSubject(nextSubject);
                },
                itemBuilder: (context) => CourseSubjectCreditStatus.values
                    .map(
                      (status) => PopupMenuItem(
                        value: status,
                        child: Text(status.label),
                      ),
                    )
                    .toList(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.assignment_turned_in_outlined),
                ),
              ),
            IconButton(
              onPressed: () => context.push('/subjects/${subject.id}'),
              icon: const Icon(Icons.library_books_rounded),
            ),
            IconButton(
              onPressed: () => context.push('/subjects/${subject.id}/edit'),
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () => _confirmDelete(context, ref, subject.id),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(BuildContext context) {
    return switch (subject.status) {
      CourseSubjectStatus.notStarted => Theme.of(context).colorScheme.outline,
      CourseSubjectStatus.inProgress => const Color(0xFF0F766E),
      CourseSubjectStatus.completed => const Color(0xFF2E7D32),
      CourseSubjectStatus.failed => Theme.of(context).colorScheme.error,
      CourseSubjectStatus.dropped => const Color(0xFF6B7280),
    };
  }

  Color _creditStatusColor(BuildContext context) {
    return switch (subject.creditStatus) {
      CourseSubjectCreditStatus.none => Theme.of(context).colorScheme.outline,
      CourseSubjectCreditStatus.suggested => const Color(0xFF2563EB),
      CourseSubjectCreditStatus.requested => const Color(0xFF7C3AED),
      CourseSubjectCreditStatus.approved => const Color(0xFF2E7D32),
      CourseSubjectCreditStatus.rejected => Theme.of(context).colorScheme.error,
    };
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remover disciplina?'),
            content: const Text(
              'A disciplina e as aulas vinculadas serao marcadas como removidas no armazenamento local.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Remover'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await ref.read(courseSubjectRepositoryProvider).deleteSubject(id);
  }
}

class _CreditSummaryTile extends StatelessWidget {
  const _CreditSummaryTile({
    required this.subject,
    this.sourceSubjectName,
    this.sourceProfileName,
  });

  final CourseSubject subject;
  final String? sourceSubjectName;
  final String? sourceProfileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Text(
                subject.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              StatusChip(
                label: subject.creditStatus.label,
                color: _creditStatusColor(subject.creditStatus),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            [
              if (sourceSubjectName != null) 'Origem: $sourceSubjectName',
              if (sourceProfileName != null) 'Perfil: $sourceProfileName',
              if (subject.creditMatchScore != null)
                'Compatibilidade ${(subject.creditMatchScore! * 100).round()}%',
            ].join(' - '),
          ),
        ],
      ),
    );
  }
}

Color _creditStatusColor(CourseSubjectCreditStatus status) {
  return switch (status) {
    CourseSubjectCreditStatus.none => const Color(0xFF6B7280),
    CourseSubjectCreditStatus.suggested => const Color(0xFF2563EB),
    CourseSubjectCreditStatus.requested => const Color(0xFF7C3AED),
    CourseSubjectCreditStatus.approved => const Color(0xFF2E7D32),
    CourseSubjectCreditStatus.rejected => const Color(0xFFC62828),
  };
}
