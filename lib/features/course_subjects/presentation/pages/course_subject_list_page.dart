import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final activeProfile = ref.watch(activeAcademicProfileProvider).valueOrNull;

    return AsyncValueView<List<CourseSubject>>(
      value: subjectsAsync,
      data: (subjects) => ListView(
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
                  child: _CourseSubjectCard(subject: subject),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _CourseSubjectCard extends ConsumerWidget {
  const _CourseSubjectCard({required this.subject});

  final CourseSubject subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
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
                      StatusChip(label: subject.status.label),
                      StatusChip(label: subject.type.label),
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
                    ].join(' - '),
                  ),
                  if (subject.notes != null && subject.notes!.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(subject.notes!),
                  ],
                ],
              ),
            ),
            PopupMenuButton<CourseSubjectStatus>(
              tooltip: 'Alterar status',
              onSelected: (status) {
                ref.read(courseSubjectRepositoryProvider).updateStatus(
                      subject.id,
                      status,
                    );
              },
              itemBuilder: (context) => CourseSubjectStatus.values
                  .map(
                    (status) => PopupMenuItem(
                      value: status,
                      child: Text(status.label),
                    ),
                  )
                  .toList(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.sync_alt_rounded),
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

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
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
