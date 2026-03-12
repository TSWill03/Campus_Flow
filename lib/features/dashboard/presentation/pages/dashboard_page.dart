// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_formatters.dart';
import '../../../../core/utils/weekday_labels.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/metric_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../../course_subjects/presentation/providers/course_subject_automation_service.dart';
import '../../domain/entities/attachment_deadline_reminder.dart';
import '../../domain/entities/scheduled_subject_prompt.dart';
import '../providers/dashboard_summary_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(activeAcademicProfileProvider).valueOrNull;
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final remindersAsync = ref.watch(dashboardAttachmentRemindersProvider);
    final scheduledSubjectsAsync = ref.watch(dashboardScheduledSubjectsProvider);
    final reminders = remindersAsync.valueOrNull ?? const <AttachmentDeadlineReminder>[];
    final scheduledSubjects =
        scheduledSubjectsAsync.valueOrNull ?? const <ScheduledSubjectPrompt>[];

    return AsyncValueView(
      value: summaryAsync,
      data: (summary) => ListView(
        children: [
          SectionHeader(
            title: 'Visao geral da graduacao',
            subtitle:
                'Acompanhe o curso, as horas obrigatorias e o ritmo dos estudos em um unico painel.',
            action: FilledButton.icon(
              onPressed: () => context.go('/profile'),
              icon: const Icon(Icons.edit_rounded),
              label: Text(profile == null ? 'Criar perfil' : 'Editar perfil'),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile?.courseName ?? 'Seu curso ainda nao foi cadastrado',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          profile?.institution ??
                              'Cadastre o perfil academico para liberar indicadores mais precisos.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: MetricCard(
                      title: 'Conclusao estimada',
                      value: AppFormatters.formatPercent(
                        summary.courseCompletionPercentage,
                      ),
                      subtitle:
                          '${summary.completedSubjects} de ${summary.totalSubjects} disciplinas concluidas',
                      icon: Icons.trending_up_rounded,
                      progress: summary.totalSubjects == 0
                          ? 0
                          : summary.completedSubjects / summary.totalSubjects,
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: MetricCard(
                      title: 'Tempo de estudo',
                      value: AppFormatters.formatDuration(
                        Duration(minutes: summary.totalStudyMinutes),
                      ),
                      subtitle: '${summary.totalStudySessions} sessoes registradas',
                      icon: Icons.schedule_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (profile == null)
            EmptyStateCard(
              icon: Icons.school_outlined,
              title: 'Configure seu perfil academico',
              message:
                  'Com o perfil do curso cadastrado, o dashboard consegue calcular horas faltantes e progresso com mais precisao.',
              action: FilledButton(
                onPressed: () => context.go('/profile'),
                child: const Text('Cadastrar agora'),
              ),
            )
          else
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _MetricCardBox(
                  child: MetricCard(
                    title: 'Disciplinas',
                    value: '${summary.completedSubjects}/${summary.totalSubjects}',
                    subtitle: '${summary.pendingSubjects} ainda pendentes',
                    icon: Icons.menu_book_rounded,
                    progress: summary.totalSubjects == 0
                        ? 0
                        : summary.completedSubjects / summary.totalSubjects,
                  ),
                ),
                _MetricCardBox(
                  child: MetricCard(
                    title: 'Horas complementares',
                    value: AppFormatters.formatHours(
                      summary.completedComplementaryHours,
                    ),
                    subtitle:
                        '${AppFormatters.formatHours(summary.remainingComplementaryHours)} restantes',
                    icon: Icons.verified_rounded,
                    color: const Color(0xFF2F855A),
                  ),
                ),
                _MetricCardBox(
                  child: MetricCard(
                    title: 'Horas de estagio',
                    value: AppFormatters.formatHours(summary.completedInternshipHours),
                    subtitle:
                        '${AppFormatters.formatHours(summary.remainingInternshipHours)} restantes',
                    icon: Icons.badge_rounded,
                    color: const Color(0xFFB7791F),
                  ),
                ),
                _MetricCardBox(
                  child: MetricCard(
                    title: 'Horas de extensao',
                    value: AppFormatters.formatHours(summary.completedExtensionHours),
                    subtitle:
                        '${AppFormatters.formatHours(summary.remainingExtensionHours)} restantes',
                    icon: Icons.groups_rounded,
                    color: const Color(0xFF2B6CB0),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 24),
          if (remindersAsync.isLoading || reminders.isNotEmpty) ...[
            const SectionHeader(
              title: 'Lembretes de entrega',
              subtitle:
                  'Atividades anexadas em aulas aparecem aqui para voce nao perder prazo.',
            ),
            const SizedBox(height: 16),
            if (remindersAsync.isLoading)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: LinearProgressIndicator(),
                ),
              )
            else
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: reminders
                    .map(
                      (reminder) => _ReminderCard(reminder: reminder),
                    )
                    .toList(),
              ),
            const SizedBox(height: 24),
          ],
          if (scheduledSubjectsAsync.isLoading || scheduledSubjects.isNotEmpty) ...[
            const SectionHeader(
              title: 'Aulas esperadas hoje',
              subtitle:
                  'Quando a disciplina tem dia fixo, o app lembra voce de registrar a aula ou marcar falta.',
            ),
            const SizedBox(height: 16),
            if (scheduledSubjectsAsync.isLoading)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: LinearProgressIndicator(),
                ),
              )
            else
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: scheduledSubjects
                    .map(
                      (subject) => _ScheduledSubjectPromptCard(subject: subject),
                    )
                    .toList(),
              ),
            const SizedBox(height: 24),
          ],
          const SectionHeader(
            title: 'Acessos rapidos',
            subtitle: 'Entre direto nas areas mais usadas do planejamento academico.',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _QuickActionCard(
                title: 'Disciplinas',
                message: 'Cadastre, edite status e acompanhe a grade.',
                icon: Icons.menu_book_rounded,
                onTap: () => context.go('/subjects'),
              ),
              _QuickActionCard(
                title: 'Horas obrigatorias',
                message: 'Lancamentos de atividades complementares, estagio e extensao.',
                icon: Icons.fact_check_rounded,
                onTap: () => context.go('/complementary'),
              ),
              _QuickActionCard(
                title: 'Estudos',
                message: 'Materias, topicos, tarefas e sessoes de estudo.',
                icon: Icons.timer_rounded,
                onTap: () => context.go('/study'),
              ),
              _QuickActionCard(
                title: 'Backup',
                message: 'Exporte ou importe um backup JSON local.',
                icon: Icons.backup_rounded,
                onTap: () => context.go('/settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCardBox extends StatelessWidget {
  const _MetricCardBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 280, child: child);
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.title,
    required this.message,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String message;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 28),
                const SizedBox(height: 16),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.reminder});

  final AttachmentDeadlineReminder reminder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => context.go('/subjects/${reminder.subjectId}'),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      reminder.isOverdue
                          ? Icons.warning_rounded
                          : Icons.schedule_rounded,
                      color: reminder.isOverdue
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        reminder.subjectName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(reminder.lessonTitle),
                const SizedBox(height: 6),
                Text(reminder.fileName),
                const SizedBox(height: 12),
                Text(
                  '${reminder.isOverdue ? 'Atrasada' : 'Prazo'}: '
                  '${AppFormatters.formatDateTime(reminder.dueDate)}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScheduledSubjectPromptCard extends ConsumerWidget {
  const _ScheduledSubjectPromptCard({required this.subject});

  final ScheduledSubjectPrompt subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 340,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject.subjectName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                [
                  'Hoje e ${WeekdayLabels.longLabel(subject.scheduledWeekday)}',
                  if (subject.defaultLessonHours != null)
                    'aula padrao de ${AppFormatters.formatLessonHours(subject.defaultLessonHours!)}',
                ].join(' - '),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: () => context.push(_newLessonPath(subject)),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Registrar aula'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _markAbsent(context, ref),
                    icon: const Icon(Icons.event_busy_rounded),
                    label: const Text('Marcar falta'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _newLessonPath(ScheduledSubjectPrompt subject) {
    final buffer = StringBuffer('/subjects/${subject.subjectId}/lessons/new');
    final today = DateTime.now();
    final query = <String>[
      'lessonDate=${DateTime(today.year, today.month, today.day).toIso8601String()}',
      if (subject.defaultLessonHours != null)
        'lessonHours=${subject.defaultLessonHours}',
    ];
    if (query.isNotEmpty) {
      buffer.write('?${query.join('&')}');
    }
    return buffer.toString();
  }

  Future<void> _markAbsent(BuildContext context, WidgetRef ref) async {
    final created = await ref
        .read(courseSubjectAutomationServiceProvider)
        .markAbsentToday(
          subjectId: subject.subjectId,
          defaultLessonHours: subject.defaultLessonHours,
        );
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          created
              ? 'Falta registrada para ${subject.subjectName}.'
              : 'Essa disciplina ja possui um registro para hoje.',
        ),
      ),
    );
  }
}
