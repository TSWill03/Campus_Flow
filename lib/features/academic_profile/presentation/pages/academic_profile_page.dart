import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/empty_state_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../domain/entities/academic_profile.dart';
import '../providers/academic_profile_provider.dart';

class AcademicProfilePage extends ConsumerWidget {
  const AcademicProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(academicProfilesProvider);

    return AsyncValueView<List<AcademicProfile>>(
      value: profilesAsync,
      data: (profiles) => ListView(
        children: [
          SectionHeader(
            title: 'Perfis academicos',
            subtitle:
                'Crie um perfil para cada curso, faculdade, universidade ou etapa academica. Isso permite manter graduacao, mestrado e doutorado em paralelo.',
            action: FilledButton.icon(
              onPressed: () => context.push('/profile/new'),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Novo perfil'),
            ),
          ),
          const SizedBox(height: 24),
          if (profiles.isEmpty)
            EmptyStateCard(
              icon: Icons.account_balance_outlined,
              title: 'Nenhum perfil academico',
              message:
                  'Crie seu primeiro perfil para organizar cursos de diferentes instituicoes ao mesmo tempo.',
              action: FilledButton(
                onPressed: () => context.push('/profile/new'),
                child: const Text('Criar perfil'),
              ),
            )
          else
            ...profiles.map(
              (profile) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _AcademicProfileCard(profile: profile),
              ),
            ),
        ],
      ),
    );
  }
}

class _AcademicProfileCard extends ConsumerWidget {
  const _AcademicProfileCard({required this.profile});

  final AcademicProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  profile.profileName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (profile.isActive)
                  const StatusChip(
                    label: 'Perfil ativo',
                    color: Color(0xFF2F855A),
                  ),
                if (profile.degreeLabel != null && profile.degreeLabel!.isNotEmpty)
                  StatusChip(label: profile.degreeLabel!),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${profile.institution}${_optionalText(profile.schoolName)}${_optionalText(profile.campus)}',
            ),
            const SizedBox(height: 4),
            Text(profile.courseName),
            const SizedBox(height: 8),
            Text(
              'Carga total: ${profile.totalCourseHours} h • ${profile.semesterCount} semestres',
            ),
            const SizedBox(height: 4),
            Text(
              'Horas obrigatorias: ${profile.requiredComplementaryHours} comp. • ${profile.requiredInternshipHours} estagio • ${profile.requiredExtensionHours} extensao',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!profile.isActive)
                  OutlinedButton.icon(
                    onPressed: () async {
                      await ref
                          .read(academicProfileRepositoryProvider)
                          .setActiveProfile(profile.id);
                    },
                    icon: const Icon(Icons.check_circle_outline_rounded),
                    label: const Text('Definir como ativo'),
                  ),
                OutlinedButton.icon(
                  onPressed: () => context.push('/profile/${profile.id}/edit'),
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Editar'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _confirmDelete(context, ref, profile.id),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: const Text('Remover'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _optionalText(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    return ' • $value';
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remover perfil?'),
            content: const Text(
              'O perfil sera marcado como removido. Se ele estiver ativo, outro perfil disponivel sera promovido.',
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
      await ref.read(academicProfileRepositoryProvider).deleteProfile(id);
    }
  }
}
