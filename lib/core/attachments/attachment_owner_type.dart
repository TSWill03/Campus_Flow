enum AttachmentOwnerType {
  courseSubjectLesson,
  complementaryActivity,
  internshipRecord,
}

extension AttachmentOwnerTypeX on AttachmentOwnerType {
  String get dbValue => switch (this) {
        AttachmentOwnerType.courseSubjectLesson => 'course_subject_lesson',
        AttachmentOwnerType.complementaryActivity => 'complementary_activity',
        AttachmentOwnerType.internshipRecord => 'internship_record',
      };
}
