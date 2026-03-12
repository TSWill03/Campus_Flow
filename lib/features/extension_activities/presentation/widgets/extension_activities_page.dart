// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../domain/entities/extension_activity.dart';
import '../providers/extension_activities_provider.dart';

class ExtensionActivitiesPage extends ConsumerWidget {
  const ExtensionActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(extensionActivitiesProvider);
    final activeProfile = ref.watch(activeAcademicProfileProvider).valueOrNull;

    return AsyncValueView<List<ExtensionActivity>>(
      value: activitiesAsync,
      data: (activities) => ListView(
        children: [
          SectionHeader(
            title: 'Atividades de extensao',
            subtitle:
                'Acompanhe projetos, acoes e cargas horarias relacionadas a extensao universitaria.',
            action: FilledButton.icon(
              onPressed: () => context.push('/extensions/new'),
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
                  'As atividades de extensao agora ficam vinculadas a um perfil academico especifico.',
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
              icon: Icons.groups_outlined,
              title: 'Nenhuma atividade de extensao',
              message:
                  'Cadastre atividades de extensao para acompanhar este requisito da graduacao.',
              action: FilledButton(
                onPressed: () => context.push('/extensions/new'),
                child: const Text('Cadastrar atividade'),
              ),
            )
            else
              ...activities.map(
                (activity) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(18),
                      title: Text(activity.title),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${activity.type} • ${AppFormatters.formatDate(activity.date)} • ${AppFormatters.formatHours(activity.workloadHours)}',
                            ),
                            if (activity.notes != null && activity.notes!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(activity.notes!),
                            ],
                          ],
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          StatusChip(label: activity.status.label),
                          IconButton(
                            onPressed: () =>
                                context.push('/extensions/${activity.id}/edit'),
                            icon: const Icon(Icons.edit_rounded),
                          ),
                          IconButton(
                            onPressed: () =>
                                _confirmDelete(context, ref, activity.id),
                            icon: const Icon(Icons.delete_outline_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
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
            title: const Text('Remover atividade?'),
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
      await ref.read(extensionActivityRepositoryProvider).deleteActivity(id);
    }
  }
}
