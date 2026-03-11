import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../domain/entities/study_topic.dart';
import '../providers/study_manager_provider.dart';

class StudyTopicsPage extends ConsumerWidget {
  const StudyTopicsPage({
    super.key,
    required this.subjectId,
  });

  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectAsync = ref.watch(studySubjectByIdProvider(subjectId));
    final topicsAsync = ref.watch(studyTopicsProvider(subjectId));

    return AsyncValueView(
      value: subjectAsync,
      data: (subject) => Scaffold(
        appBar: AppBar(
          title: Text(subject?.name ?? 'Topicos'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SectionHeader(
                  title: 'Topicos da materia',
                  subtitle:
                      'Quebre a materia em blocos menores para acompanhar evolucao com mais clareza.',
                  action: FilledButton.icon(
                    onPressed: () =>
                        context.push('/study/subjects/$subjectId/topics/new'),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Novo topico'),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: topicsAsync.when(
                    data: (topics) => topics.isEmpty
                        ? EmptyStateCard(
                            icon: Icons.topic_outlined,
                            title: 'Nenhum topico criado',
                            message:
                                'Adicione topicos para decompor o plano de estudo dessa materia.',
                            action: FilledButton(
                              onPressed: () => context.push(
                                '/study/subjects/$subjectId/topics/new',
                              ),
                              child: const Text('Adicionar topico'),
                            ),
                          )
                        : ListView.separated(
                            itemCount: topics.length,
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final topic = topics[index];
                              return _TopicCard(
                                subjectId: subjectId,
                                topic: topic,
                              );
                            },
                          ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) => Center(child: Text('$error')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopicCard extends ConsumerWidget {
  const _TopicCard({
    required this.subjectId,
    required this.topic,
  });

  final String subjectId;
  final StudyTopic topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        title: Text(topic.name),
        subtitle: topic.description == null || topic.description!.isEmpty
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(topic.description!),
              ),
        trailing: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            StatusChip(label: topic.status.label),
            IconButton(
              onPressed: () => context.push(
                '/study/subjects/$subjectId/topics/${topic.id}/edit',
              ),
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () => _confirmDelete(context, ref, topic.id),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          ],
        ),
      ),
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
            title: const Text('Remover topico?'),
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
      await ref.read(studyManagerRepositoryProvider).deleteTopic(id);
    }
  }
}
