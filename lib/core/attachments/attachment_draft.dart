import 'attachment_category.dart';

class AttachmentDraft {
  const AttachmentDraft({
    required this.id,
    required this.fileName,
    required this.bytes,
    required this.category,
    this.mimeType,
    this.dueDate,
    this.isCompleted = false,
  });

  final String id;
  final String fileName;
  final List<int> bytes;
  final String? mimeType;
  final AttachmentCategory category;
  final DateTime? dueDate;
  final bool isCompleted;

  AttachmentDraft copyWith({
    String? id,
    String? fileName,
    List<int>? bytes,
    String? mimeType,
    AttachmentCategory? category,
    DateTime? dueDate,
    bool clearDueDate = false,
    bool? isCompleted,
  }) {
    return AttachmentDraft(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      bytes: bytes ?? this.bytes,
      mimeType: mimeType ?? this.mimeType,
      category: category ?? this.category,
      dueDate: clearDueDate ? null : dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
