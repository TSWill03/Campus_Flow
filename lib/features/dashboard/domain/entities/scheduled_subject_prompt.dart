// Signature: dev.tswicolly03

class ScheduledSubjectPrompt {
  const ScheduledSubjectPrompt({
    required this.subjectId,
    required this.subjectName,
    required this.scheduledWeekday,
    required this.defaultLessonHours,
  });

  final String subjectId;
  final String subjectName;
  final int scheduledWeekday;
  final double? defaultLessonHours;
}
