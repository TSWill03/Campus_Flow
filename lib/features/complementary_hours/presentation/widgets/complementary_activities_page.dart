// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/attachments/attachment_providers.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/attachment_list_section.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../domain/entities/complementary_activity.dart';
import '../providers/complementary_activities_provider.dart';

class ComplementaryActivitiesPage extends ConsumerWidget {
  const ComplementaryActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(complementaryActivitiesProvider);
    final activeProfile = ref.watch(activeAcademicProfileProvider).valueOrNull;

    return AsyncValueView<List<ComplementaryActivity>>(
      value: activitiesAsync,
      data: (activities) => ListView(
        children: [
          SectionHeader(
            title: 'Atividades complementares',
            subtitle:
                'Registre certificados, eventos e comprovantes para acompanhar o requisito complementar.',
            action: FilledButton.icon(
              onPressed: () => context.push('/complementary/new'),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Nova atividade'),
            ),
          ),
          const SizedBox(height: 24),
          if (activeProfile == null)
            EmptyStateCard(
              icon: Icons.account_balance_outlined,
              title: 'Selecione um perfil academico',
              message:
                  'As atividades complementares agora ficam vinculadas a um perfil academico.',
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
            if (activities.isEmpty)
              EmptyStateCard(
                icon: Icons.verified_outlined,
                title: 'Nenhuma atividade complementar',
                message:
                    'Cadastre suas atividades para manter o historico academico atualizado.',
                action: FilledButton(
                  onPressed: () => context.push('/complementary/new'),
                  child: const Text('Cadastrar atividade'),
                ),
              )
            else
              ...activities.map(
                (activity) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ComplementaryActivityCard(activity: activity),
                ),
              ),
          ],
        ],
      ),
    );
  }

}

class _ComplementaryActivityCard extends ConsumerWidget {
  const _ComplementaryActivityCard({required this.activity});

  final ComplementaryActivity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentsAsync = ref.watch(
      ownerAttachmentsProvider(
        (
          ownerType: AttachmentOwnerType.complementaryActivity,
          ownerId: activity.id,
        ),
      ),
    );
    final attachments = attachmentsAsync.valueOrNull ?? const [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            activity.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          StatusChip(label: activity.status.label),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        [
                          activity.category,
                          _formatDateRange(activity),
                          AppFormatters.formatHours(activity.workloadHours),
                        ].join(' - '),
                      ),
                      if (activity.notes != null && activity.notes!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(activity.notes!),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.push('/complementary/${activity.id}/edit'),
                  icon: const Icon(Icons.edit_rounded),
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context, ref, activity.id),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (attachmentsAsync.isLoading)
              const LinearProgressIndicator()
            else
              AttachmentListSection(
                title: 'Comprovantes',
                subtitle:
                    'Certificados, declaracoes, PDFs, arquivos compactados e outros anexos da atividade.',
                attachments: attachments,
                emptyMessage: 'Nenhum comprovante anexado.',
              ),
          ],
        ),
      ),
    );
  }

  String _formatDateRange(ComplementaryActivity activity) {
    final start = AppFormatters.formatDate(activity.date);
    if (activity.endDate == null || activity.endDate == activity.date) {
      return start;
    }
    return '$start ate ${AppFormatters.formatDate(activity.endDate)}';
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remover atividade?'),
            content: const Text(
              'A atividade sera marcada como removida no banco local.',
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

    if (confirmed) {
      await ref.read(complementaryActivityRepositoryProvider).deleteActivity(id);
    }
  }
}
