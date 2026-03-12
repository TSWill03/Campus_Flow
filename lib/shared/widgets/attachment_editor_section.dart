// Signature: dev.tswicolly03

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/attachments/attachment_category.dart';
import '../../core/attachments/attachment_draft.dart';
import '../../core/attachments/attachment_file_opener.dart';
import '../../core/utils/app_formatters.dart';
import '../../core/utils/id_generator.dart';

class AttachmentEditorSection extends StatelessWidget {
  const AttachmentEditorSection({
    super.key,
    required this.title,
    required this.attachments,
    required this.allowedCategories,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<AttachmentDraft> attachments;
  final List<AttachmentCategory> allowedCategories;
  final ValueChanged<List<AttachmentDraft>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle!),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _pickFiles(context),
                  icon: const Icon(Icons.attach_file_rounded),
                  label: const Text('Anexar arquivos'),
                ),
                if (attachments.isNotEmpty)
                  TextButton.icon(
                    onPressed: () => onChanged(const []),
                    icon: const Icon(Icons.delete_sweep_rounded),
                    label: const Text('Limpar todos'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (attachments.isEmpty)
              const Text('Nenhum arquivo anexado.')
            else
              ...attachments.map(
                (attachment) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _AttachmentCard(
                    attachment: attachment,
                    allowedCategories: allowedCategories,
                    onChanged: (updated) {
                      final next = [...attachments];
                      final index =
                          next.indexWhere((item) => item.id == attachment.id);
                      if (index >= 0) {
                        next[index] = updated;
                        onChanged(next);
                      }
                    },
                    onRemove: () {
                      onChanged(
                        attachments
                            .where((item) => item.id != attachment.id)
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFiles(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final next = [...attachments];
    for (final file in result.files) {
      if (file.bytes == null) {
        continue;
      }

      next.add(
        AttachmentDraft(
          id: IdGenerator.generate(),
          fileName: file.name,
          bytes: file.bytes!,
          mimeType: _guessMimeType(file.extension),
          category: allowedCategories.first,
        ),
      );
    }
    onChanged(next);
  }

  String? _guessMimeType(String? extension) {
    return switch (extension?.toLowerCase()) {
      'pdf' => 'application/pdf',
      'txt' => 'text/plain',
      'json' => 'application/json',
      'csv' => 'text/csv',
      'zip' => 'application/zip',
      'rar' => 'application/vnd.rar',
      '7z' => 'application/x-7z-compressed',
      'doc' => 'application/msword',
      'docx' =>
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls' => 'application/vnd.ms-excel',
      'xlsx' =>
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'ppt' => 'application/vnd.ms-powerpoint',
      'pptx' =>
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      _ => null,
    };
  }
}

class _AttachmentCard extends StatelessWidget {
  const _AttachmentCard({
    required this.attachment,
    required this.allowedCategories,
    required this.onChanged,
    required this.onRemove,
  });

  final AttachmentDraft attachment;
  final List<AttachmentCategory> allowedCategories;
  final ValueChanged<AttachmentDraft> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachment.fileName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(_formatBytes(attachment.bytes.length)),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => _openAttachment(context),
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text('Abrir'),
              ),
              TextButton.icon(
                onPressed: () => _downloadAttachment(context),
                icon: const Icon(Icons.download_rounded),
                label: const Text('Salvar copia'),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<AttachmentCategory>(
            initialValue: attachment.category,
            decoration: const InputDecoration(labelText: 'Tipo do arquivo'),
            items: allowedCategories
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.label),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              onChanged(
                attachment.copyWith(
                  category: value,
                  clearDueDate: !value.supportsDeadline,
                  isCompleted: value.supportsDeadline ? attachment.isCompleted : false,
                ),
              );
            },
          ),
          if (attachment.category.supportsDeadline) ...[
            const SizedBox(height: 12),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              title: const Text('Prazo de entrega'),
              subtitle: Text(
                attachment.dueDate == null
                    ? 'Nao definido'
                    : AppFormatters.formatDateTime(attachment.dueDate),
              ),
              trailing: Wrap(
                spacing: 4,
                children: [
                  if (attachment.dueDate != null)
                    IconButton(
                      onPressed: () => onChanged(
                        attachment.copyWith(clearDueDate: true),
                      ),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  const Icon(Icons.schedule_rounded),
                ],
              ),
              onTap: () => _pickDueDate(context),
            ),
            CheckboxListTile(
              value: attachment.isCompleted,
              contentPadding: EdgeInsets.zero,
              title: const Text('Atividade ja entregue'),
              onChanged: (value) {
                onChanged(attachment.copyWith(isCompleted: value ?? false));
              },
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _pickDueDate(BuildContext context) async {
    final initialDate = attachment.dueDate ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null || !context.mounted) {
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(attachment.dueDate ?? DateTime.now()),
    );
    if (time == null) {
      return;
    }

    onChanged(
      attachment.copyWith(
        dueDate: DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ),
      ),
    );
  }

  Future<void> _downloadAttachment(BuildContext context) async {
    String? path;
    try {
      path = await FilePicker.platform.saveFile(
        dialogTitle: 'Salvar arquivo anexado',
        fileName: attachment.fileName,
        type: FileType.any,
        bytes: Uint8List.fromList(attachment.bytes),
      );
    } catch (_) {
      path = null;
    }

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          path == null
              ? 'Nao foi possivel salvar uma copia nesta plataforma agora.'
              : 'Arquivo salvo com sucesso.',
        ),
      ),
    );
  }

  Future<void> _openAttachment(BuildContext context) async {
    final result = await openAttachmentBytes(
      fileName: attachment.fileName,
      bytes: attachment.bytes,
      mimeType: attachment.mimeType,
    );

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result.message)),
    );
  }

  String _formatBytes(int length) {
    if (length < 1024) {
      return '$length B';
    }
    if (length < 1024 * 1024) {
      return '${(length / 1024).toStringAsFixed(1)} KB';
    }
    return '${(length / math.pow(1024, 2)).toStringAsFixed(1)} MB';
  }
}
