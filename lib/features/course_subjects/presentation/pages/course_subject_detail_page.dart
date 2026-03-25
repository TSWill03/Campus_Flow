// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/attachments/attachment_category.dart';
import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/attachments/attachment_providers.dart';
import '../../../../core/attachments/stored_attachment.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/utils/weekday_labels.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/attachment_list_section.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../academic_profile/domain/entities/academic_profile.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../domain/entities/course_subject.dart';
import '../../domain/entities/course_subject_lesson.dart';
import '../providers/course_subjects_provider.dart';

class CourseSubjectDetailPage extends ConsumerStatefulWidget {
  const CourseSubjectDetailPage({
    super.key,
    required this.subjectId,
    this.startLessonOnOpen = false,
  });

  final String subjectId;
  final bool startLessonOnOpen;

  @override
  ConsumerState<CourseSubjectDetailPage> createState() =>
      _CourseSubjectDetailPageState();
}

class _CourseSubjectDetailPageState
    extends ConsumerState<CourseSubjectDetailPage> {
  bool _lessonAutoOpened = false;

  @override
  Widget build(BuildContext context) {
    final subjectAsync = ref.watch(courseSubjectByIdProvider(widget.subjectId));

    return AsyncValueView<CourseSubject?>(
      value: subjectAsync,
      data: (subject) {
        if (subject == null) {
          return const Center(child: Text('Disciplina nao encontrada.'));
        }
        final allSubjects =
            ref.watch(allCourseSubjectsProvider).valueOrNull ??
            const <CourseSubject>[];
        final profiles =
            ref.watch(academicProfilesProvider).valueOrNull ??
            const <AcademicProfile>[];
        String? sourceSubjectName;
        if (subject.creditSourceSubjectId != null) {
          for (final item in allSubjects) {
            if (item.id == subject.creditSourceSubjectId) {
              sourceSubjectName = item.name;
              break;
            }
          }
        }
        String? sourceProfileName;
        if (subject.creditSourceProfileId != null) {
          for (final item in profiles) {
            if (item.id == subject.creditSourceProfileId) {
              sourceProfileName = item.profileName;
              break;
            }
          }
        }

        if (widget.startLessonOnOpen && !_lessonAutoOpened) {
          _lessonAutoOpened = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.push(_newLessonPath(subject));
            }
          });
        }

        final lessonsAsync = ref.watch(
          courseSubjectLessonsProvider(subject.id),
        );
        return AsyncValueView<List<CourseSubjectLesson>>(
          value: lessonsAsync,
          data: (lessons) => ListView(
            children: [
              SectionHeader(
                title: subject.name,
                subtitle:
                    'Registre cada aula, anexos, atividades e provas para montar um historico completo da disciplina.',
                action: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => context.go('/subjects'),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Voltar'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () =>
                          context.push('/subjects/${subject.id}/edit'),
                      icon: const Icon(Icons.edit_rounded),
                      label: const Text('Editar disciplina'),
                    ),
                    FilledButton.icon(
                      onPressed: () => context.push(_newLessonPath(subject)),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Nova aula'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _SummaryTile(
                        label: 'Status',
                        value: subject.status.label,
                      ),
                      _SummaryTile(label: 'Tipo', value: subject.type.label),
                      _SummaryTile(
                        label: 'Carga total',
                        value: '${subject.workloadHours} h',
                      ),
                      _SummaryTile(
                        label: 'Aulas registradas',
                        value: '${lessons.length}',
                      ),
                      _SummaryTile(
                        label: 'Horas registradas',
                        value: AppFormatters.formatLessonHours(
                          lessons.fold<double>(
                            0,
                            (total, lesson) =>
                                total +
                                (lesson.wasAbsent ? 0 : lesson.lessonHours),
                          ),
                        ),
                      ),
                      if (subject.scheduledWeekday != null)
                        _SummaryTile(
                          label: 'Dia fixo',
                          value: WeekdayLabels.longLabel(
                            subject.scheduledWeekday!,
                          )!,
                        ),
                      if (subject.defaultLessonHours != null)
                        _SummaryTile(
                          label: 'Duracao padrao',
                          value: AppFormatters.formatLessonHours(
                            subject.defaultLessonHours!,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (subject.creditStatus != CourseSubjectCreditStatus.none) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Aproveitamento',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            StatusChip(
                              label: subject.creditStatus.label,
                              color: _creditStatusColor(subject.creditStatus),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          [
                            if (sourceSubjectName != null)
                              'Disciplina de origem: $sourceSubjectName',
                            if (sourceProfileName != null)
                              'Perfil de origem: $sourceProfileName',
                            if (subject.creditMatchScore != null)
                              'Compatibilidade ${(subject.creditMatchScore! * 100).round()}%',
                          ].join('\n'),
                        ),
                        const SizedBox(height: 12),
                        Text(switch (subject.creditStatus) {
                          CourseSubjectCreditStatus.suggested =>
                            'O sistema encontrou uma equivalencia forte com outra disciplina. Vale revisar os documentos antes de solicitar.',
                          CourseSubjectCreditStatus.requested =>
                            'Essa disciplina ja esta marcada como aproveitamento solicitado, com origem registrada para acompanhamento.',
                          CourseSubjectCreditStatus.approved =>
                            'O aproveitamento desta disciplina foi aprovado e permanece vinculado ao historico de origem.',
                          CourseSubjectCreditStatus.rejected =>
                            'Esse aproveitamento foi negado. Voce pode manter o vinculo como historico ou limpar a referencia na edicao.',
                          CourseSubjectCreditStatus.none => '',
                        }, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ],
              if (subject.notes != null &&
                  subject.notes!.trim().isNotEmpty) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(subject.notes!),
                  ),
                ),
              ],
              if (subject.syllabus != null &&
                  subject.syllabus!.trim().isNotEmpty) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ementa',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(subject.syllabus!),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Aulas',
                subtitle:
                    'Cada aula pode guardar conteudo, observacoes, provas e quantos arquivos voce precisar.',
              ),
              const SizedBox(height: 16),
              if (lessons.isEmpty)
                EmptyStateCard(
                  icon: Icons.history_edu_outlined,
                  title: 'Nenhuma aula registrada',
                  message:
                      'Assim que voce tiver uma aula, registre o conteudo e os materiais para montar um historico util da disciplina.',
                  action: FilledButton(
                    onPressed: () => context.push(_newLessonPath(subject)),
                    child: const Text('Registrar primeira aula'),
                  ),
                )
              else
                ...lessons.map(
                  (lesson) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _LessonCard(
                      lesson: lesson,
                      onEdit: () => context.push(
                        '/subjects/${subject.id}/lessons/${lesson.id}/edit',
                      ),
                      onDelete: () => _confirmDeleteLesson(context, lesson.id),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmDeleteLesson(
    BuildContext context,
    String lessonId,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remover aula?'),
            content: const Text(
              'A aula sera marcada como removida no armazenamento local.',
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

    await ref.read(courseSubjectRepositoryProvider).deleteLesson(lessonId);
  }

  String _newLessonPath(CourseSubject subject) {
    if (subject.defaultLessonHours == null) {
      return '/subjects/${subject.id}/lessons/new';
    }
    return '/subjects/${subject.id}/lessons/new?lessonHours=${subject.defaultLessonHours}';
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
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _LessonCard extends ConsumerWidget {
  const _LessonCard({
    required this.lesson,
    required this.onEdit,
    required this.onDelete,
  });

  final CourseSubjectLesson lesson;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentsAsync = ref.watch(
      ownerAttachmentsProvider((
        ownerType: AttachmentOwnerType.courseSubjectLesson,
        ownerId: lesson.id,
      )),
    );
    final attachments = attachmentsAsync.valueOrNull;
    final resolvedAttachments = attachments != null && attachments.isNotEmpty
        ? attachments
        : _legacyAttachments();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  lesson.coveredContent,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                StatusChip(label: AppFormatters.formatDate(lesson.lessonDate)),
                if (!lesson.wasAbsent)
                  StatusChip(
                    label: AppFormatters.formatLessonHours(lesson.lessonHours),
                  ),
                if (lesson.wasAbsent)
                  const StatusChip(label: 'Falta registrada'),
                if (resolvedAttachments.isNotEmpty)
                  StatusChip(label: '${resolvedAttachments.length} arquivo(s)'),
                if (lesson.assessmentDate != null) StatusChip(label: 'Prova'),
              ],
            ),
            if (lesson.wasAbsent) ...[
              const SizedBox(height: 12),
              Text(
                'Voce marcou falta nesta aula. Se quiser, depois pode editar esse registro.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (lesson.description != null &&
                lesson.description!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(lesson.description!),
            ],
            if (lesson.activityDescription != null &&
                lesson.activityDescription!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Atividade: ${lesson.activityDescription!}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (lesson.assessmentDescription != null ||
                lesson.assessmentDate != null) ...[
              const SizedBox(height: 12),
              Text(
                [
                  if (lesson.assessmentDescription != null &&
                      lesson.assessmentDescription!.trim().isNotEmpty)
                    lesson.assessmentDescription!,
                  if (lesson.assessmentDate != null)
                    'Data: ${AppFormatters.formatDate(lesson.assessmentDate)}',
                ].join(' - '),
              ),
            ],
            if (attachmentsAsync.isLoading && resolvedAttachments.isEmpty) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(),
            ] else if (resolvedAttachments.isNotEmpty) ...[
              const SizedBox(height: 16),
              AttachmentListSection(
                title: 'Arquivos da aula',
                subtitle:
                    'Abra materiais, salve copias e acompanhe prazos das atividades anexadas.',
                attachments: resolvedAttachments,
                emptyMessage: 'Nenhum arquivo anexado.',
                onToggleCompleted: (attachment, isCompleted) async {
                  await ref
                      .read(attachmentRepositoryProvider)
                      .updateCompletionStatus(
                        attachmentId: attachment.id,
                        isCompleted: isCompleted,
                      );
                },
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_rounded),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<StoredAttachment> _legacyAttachments() {
    if (lesson.pdfName == null || lesson.pdfBytes == null) {
      return const [];
    }

    return [
      StoredAttachment(
        id: 'legacy_${lesson.id}',
        createdAt: lesson.createdAt,
        updatedAt: lesson.updatedAt,
        syncStatus: lesson.syncStatus,
        isDeleted: false,
        ownerType: AttachmentOwnerType.courseSubjectLesson,
        ownerId: lesson.id,
        fileName: lesson.pdfName!,
        bytes: lesson.pdfBytes!,
        mimeType: 'application/pdf',
        category: AttachmentCategory.document,
      ),
    ];
  }
}
