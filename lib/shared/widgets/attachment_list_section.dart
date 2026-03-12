// Signature: dev.tswicolly03

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/attachments/attachment_category.dart';
import '../../core/attachments/attachment_file_opener.dart';
import '../../core/attachments/stored_attachment.dart';
import '../../core/utils/app_formatters.dart';
import 'status_chip.dart';

typedef AttachmentCompletionToggle =
    Future<void> Function(StoredAttachment attachment, bool isCompleted);

class AttachmentListSection extends StatelessWidget {
  const AttachmentListSection({
    super.key,
    required this.attachments,
    required this.emptyMessage,
    this.title,
    this.subtitle,
    this.onToggleCompleted,
  });

  final String? title;
  final String? subtitle;
  final List<StoredAttachment> attachments;
  final String emptyMessage;
  final AttachmentCompletionToggle? onToggleCompleted;

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty && title == null && subtitle == null) {
      return Text(emptyMessage);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
        ],
        if (subtitle != null) ...[
          Text(subtitle!),
          const SizedBox(height: 12),
        ],
        if (attachments.isEmpty)
          Text(emptyMessage)
        else
          ...attachments.map(
            (attachment) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _AttachmentTile(
                attachment: attachment,
                onToggleCompleted: onToggleCompleted,
              ),
            ),
          ),
      ],
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({
    required this.attachment,
    this.onToggleCompleted,
  });

  final StoredAttachment attachment;
  final AttachmentCompletionToggle? onToggleCompleted;

  @override
  Widget build(BuildContext context) {
    final deadlineState = _deadlineState(attachment);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _iconForCategory(),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
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
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        StatusChip(label: attachment.category.label),
                        if (attachment.dueDate != null)
                          StatusChip(
                            label:
                                'Prazo ${AppFormatters.formatDateTime(attachment.dueDate)}',
                            color: deadlineState.color,
                          ),
                        if (deadlineState.label != null)
                          StatusChip(
                            label: deadlineState.label!,
                            color: deadlineState.color,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _openAttachment(context),
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text('Abrir'),
              ),
              TextButton.icon(
                onPressed: () => _saveCopy(context),
                icon: const Icon(Icons.download_rounded),
                label: const Text('Salvar copia'),
              ),
              if (attachment.category.supportsDeadline && onToggleCompleted != null)
                TextButton.icon(
                  onPressed: () => onToggleCompleted!(
                    attachment,
                    !attachment.isCompleted,
                  ),
                  icon: Icon(
                    attachment.isCompleted
                        ? Icons.undo_rounded
                        : Icons.check_circle_outline_rounded,
                  ),
                  label: Text(
                    attachment.isCompleted ? 'Marcar pendente' : 'Marcar entregue',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory() {
    return switch (attachment.category) {
      AttachmentCategory.activity => Icons.assignment_rounded,
      AttachmentCategory.slide => Icons.slideshow_rounded,
      AttachmentCategory.certificate => Icons.workspace_premium_rounded,
      AttachmentCategory.document => Icons.description_outlined,
      AttachmentCategory.archive => Icons.folder_zip_rounded,
      AttachmentCategory.lessonMaterial => Icons.menu_book_rounded,
      AttachmentCategory.other => Icons.attach_file_rounded,
    };
  }

  _DeadlineState _deadlineState(StoredAttachment attachment) {
    if (!attachment.category.supportsDeadline) {
      return const _DeadlineState();
    }
    if (attachment.isCompleted) {
      return const _DeadlineState(
        label: 'Entregue',
        color: Color(0xFF2F855A),
      );
    }
    final dueDate = attachment.dueDate;
    if (dueDate != null && dueDate.isBefore(DateTime.now())) {
      return const _DeadlineState(
        label: 'Atrasada',
        color: Color(0xFFC53030),
      );
    }
    return const _DeadlineState(
      label: 'Pendente',
      color: Color(0xFFB7791F),
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

  Future<void> _saveCopy(BuildContext context) async {
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

class _DeadlineState {
  const _DeadlineState({
    this.label,
    this.color = const Color(0xFF0F766E),
  });

  final String? label;
  final Color color;
}
