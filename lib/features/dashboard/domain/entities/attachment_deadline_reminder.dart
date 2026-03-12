// Signature: dev.tswicolly03

class AttachmentDeadlineReminder {
  const AttachmentDeadlineReminder({
    required this.attachmentId,
    required this.subjectId,
    required this.subjectName,
    required this.lessonTitle,
    required this.fileName,
    required this.dueDate,
  });

  final String attachmentId;
  final String subjectId;
  final String subjectName;
  final String lessonTitle;
  final String fileName;
  final DateTime dueDate;

  bool get isOverdue => dueDate.isBefore(DateTime.now());
}
