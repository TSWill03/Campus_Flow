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
import '../../domain/entities/internship_record.dart';
import '../providers/internships_provider.dart';

class InternshipsPage extends ConsumerWidget {
  const InternshipsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internshipsAsync = ref.watch(internshipsProvider);
    final activeProfile = ref.watch(activeAcademicProfileProvider).valueOrNull;

    return AsyncValueView<List<InternshipRecord>>(
      value: internshipsAsync,
      data: (internships) => ListView(
        children: [
          SectionHeader(
            title: 'Estagios',
            subtitle:
                'Mantenha o historico de estagios, horas cumpridas e documentos de cada experiencia.',
            action: FilledButton.icon(
              onPressed: () => context.push('/internships/new'),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Novo estagio'),
            ),
          ),
          const SizedBox(height: 24),
          if (activeProfile == null)
            EmptyStateCard(
              icon: Icons.account_balance_outlined,
              title: 'Selecione um perfil academico',
              message:
                  'Os estagios agora ficam vinculados a um perfil academico especifico.',
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
            if (internships.isEmpty)
              EmptyStateCard(
                icon: Icons.badge_outlined,
                title: 'Nenhum estagio cadastrado',
                message:
                    'Registre local, supervisor e carga horaria para acompanhar o requisito de estagio.',
                action: FilledButton(
                  onPressed: () => context.push('/internships/new'),
                  child: const Text('Cadastrar estagio'),
                ),
              )
            else
              ...internships.map(
                (internship) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _InternshipCard(internship: internship),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _InternshipCard extends ConsumerWidget {
  const _InternshipCard({required this.internship});

  final InternshipRecord internship;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentsAsync = ref.watch(
      ownerAttachmentsProvider(
        (
          ownerType: AttachmentOwnerType.internshipRecord,
          ownerId: internship.id,
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
                            internship.location,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          StatusChip(label: internship.status.label),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${AppFormatters.formatDate(internship.startDate)} - '
                        '${AppFormatters.formatDate(internship.endDate)}',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${AppFormatters.formatHours(internship.completedHours)} de '
                        '${AppFormatters.formatHours(internship.totalHours)}',
                      ),
                      if (internship.supervisor != null &&
                          internship.supervisor!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text('Supervisor: ${internship.supervisor}'),
                      ],
                      if (internship.notes != null &&
                          internship.notes!.trim().isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(internship.notes!),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.push('/internships/${internship.id}/edit'),
                  icon: const Icon(Icons.edit_rounded),
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context, ref, internship.id),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (attachmentsAsync.isLoading)
              const LinearProgressIndicator()
            else
              AttachmentListSection(
                title: 'Documentos do estagio',
                subtitle:
                    'Termos, declaracoes, relatorios, certificados e outros anexos do estagio.',
                attachments: attachments,
                emptyMessage: 'Nenhum documento anexado.',
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
            title: const Text('Remover estagio?'),
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
      await ref.read(internshipRepositoryProvider).deleteInternship(id);
    }
  }
}
