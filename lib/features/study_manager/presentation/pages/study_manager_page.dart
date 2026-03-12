// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../domain/entities/study_session.dart';
import '../../domain/entities/study_subject.dart';
import '../../domain/entities/study_task.dart';
import '../../domain/entities/study_topic.dart';
import '../providers/study_manager_provider.dart';

class StudyManagerPage extends ConsumerWidget {
  const StudyManagerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(studySubjectsProvider);
    final tasksAsync = ref.watch(studyTasksProvider);
    final sessionsAsync = ref.watch(studySessionsProvider);
    final allTopics = ref.watch(studyAllTopicsProvider).valueOrNull ?? const [];

    final subjectMap = {
      for (final subject in subjectsAsync.valueOrNull ?? const <StudySubject>[])
        subject.id: subject,
    };
    final topicMap = {for (final topic in allTopics) topic.id: topic};

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const SectionHeader(
            title: 'Gerenciador de estudos',
            subtitle:
                'Organize materias independentes da grade, crie tarefas e acompanhe o historico das sessoes.',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => context.push('/study/subjects/new'),
                icon: const Icon(Icons.library_add_rounded),
                label: const Text('Nova materia'),
              ),
              OutlinedButton.icon(
                onPressed: () => context.push('/study/tasks/new'),
                icon: const Icon(Icons.playlist_add_check_rounded),
                label: const Text('Nova tarefa'),
              ),
              OutlinedButton.icon(
                onPressed: () => context.push('/study/sessions/new'),
                icon: const Icon(Icons.timer_rounded),
                label: const Text('Nova sessao'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TabBar(
            isScrollable: true,
            tabs: const [
              Tab(text: 'Materias'),
              Tab(text: 'Tarefas'),
              Tab(text: 'Sessoes'),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children: [
                subjectsAsync.when(
                  data: (subjects) => _SubjectsTab(subjects: subjects),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('$error')),
                ),
                tasksAsync.when(
                  data: (tasks) => _TasksTab(
                    tasks: tasks,
                    subjectMap: subjectMap,
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('$error')),
                ),
                sessionsAsync.when(
                  data: (sessions) => _SessionsTab(
                    sessions: sessions,
                    subjectMap: subjectMap,
                    topicMap: topicMap,
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('$error')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectsTab extends ConsumerWidget {
  const _SubjectsTab({required this.subjects});

  final List<StudySubject> subjects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (subjects.isEmpty) {
      return EmptyStateCard(
        icon: Icons.menu_book_outlined,
        title: 'Nenhuma materia de estudo',
        message:
            'Crie materias independentes da grade para organizar revisoes, certificacoes ou estudos paralelos.',
        action: FilledButton(
          onPressed: () => context.push('/study/subjects/new'),
          child: const Text('Criar materia'),
        ),
      );
    }

    return ListView.separated(
      itemCount: subjects.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final subject = subjects[index];
        final color = subject.colorValue != null ? Color(subject.colorValue!) : null;

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(18),
            leading: CircleAvatar(
              backgroundColor:
                  (color ?? Theme.of(context).colorScheme.primary)
                      .withValues(alpha: 0.18),
              child: Icon(
                Icons.book_rounded,
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(subject.name),
            subtitle: subject.description == null || subject.description!.isEmpty
                ? null
                : Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(subject.description!),
                  ),
            trailing: Wrap(
              spacing: 4,
              children: [
                TextButton(
                  onPressed: () =>
                      context.push('/study/subjects/${subject.id}/topics'),
                  child: const Text('Topicos'),
                ),
                IconButton(
                  onPressed: () =>
                      context.push('/study/subjects/${subject.id}/edit'),
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
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remover materia?'),
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

    if (confirmed) {
      await ref.read(studyManagerRepositoryProvider).deleteSubject(id);
    }
  }
}

class _TasksTab extends ConsumerWidget {
  const _TasksTab({
    required this.tasks,
    required this.subjectMap,
  });

  final List<StudyTask> tasks;
  final Map<String, StudySubject> subjectMap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tasks.isEmpty) {
      return EmptyStateCard(
        icon: Icons.task_outlined,
        title: 'Nenhuma tarefa de estudo',
        message: 'Adicione tarefas com prioridade e prazo para manter o foco.',
        action: FilledButton(
          onPressed: () => context.push('/study/tasks/new'),
          child: const Text('Criar tarefa'),
        ),
      );
    }

    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final task = tasks[index];
        final subject = task.studySubjectId == null
            ? null
            : subjectMap[task.studySubjectId];

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(18),
            title: Text(task.title),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject?.name ?? 'Sem materia vinculada'),
                  if (task.dueDate != null) ...[
                    const SizedBox(height: 4),
                    Text('Prazo: ${AppFormatters.formatDate(task.dueDate)}'),
                  ],
                  if (task.description != null && task.description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(task.description!),
                  ],
                ],
              ),
            ),
            trailing: Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatusChip(label: task.priority.label),
                StatusChip(label: task.status.label),
                IconButton(
                  onPressed: () => context.push('/study/tasks/${task.id}/edit'),
                  icon: const Icon(Icons.edit_rounded),
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context, ref, task.id),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remover tarefa?'),
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

    if (confirmed) {
      await ref.read(studyManagerRepositoryProvider).deleteTask(id);
    }
  }
}

class _SessionsTab extends ConsumerWidget {
  const _SessionsTab({
    required this.sessions,
    required this.subjectMap,
    required this.topicMap,
  });

  final List<StudySession> sessions;
  final Map<String, StudySubject> subjectMap;
  final Map<String, StudyTopic> topicMap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (sessions.isEmpty) {
      return EmptyStateCard(
        icon: Icons.timer_outlined,
        title: 'Nenhuma sessao de estudo',
        message:
            'Registre seu tempo dedicado aos estudos para formar um historico confiavel.',
        action: FilledButton(
          onPressed: () => context.push('/study/sessions/new'),
          child: const Text('Registrar sessao'),
        ),
      );
    }

    return ListView.separated(
      itemCount: sessions.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final session = sessions[index];
        final subject = session.studySubjectId == null
            ? null
            : subjectMap[session.studySubjectId];
        final topic =
            session.studyTopicId == null ? null : topicMap[session.studyTopicId];

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(18),
            title: Text(subject?.name ?? 'Sessao sem materia vinculada'),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic?.name ?? 'Sem topico especifico'),
                  const SizedBox(height: 4),
                  Text(
                    '${AppFormatters.formatDate(session.startedAt)} • ${AppFormatters.formatDuration(Duration(minutes: session.durationMinutes))}',
                  ),
                  if (session.notes != null && session.notes!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(session.notes!),
                  ],
                ],
              ),
            ),
            trailing: Wrap(
              spacing: 4,
              children: [
                IconButton(
                  onPressed: () => context.push('/study/sessions/${session.id}/edit'),
                  icon: const Icon(Icons.edit_rounded),
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context, ref, session.id),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remover sessao?'),
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

    if (confirmed) {
      await ref.read(studyManagerRepositoryProvider).deleteSession(id);
    }
  }
}
