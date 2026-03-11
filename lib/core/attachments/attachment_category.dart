enum AttachmentCategory {
  lessonMaterial,
  activity,
  slide,
  certificate,
  document,
  archive,
  other,
}

extension AttachmentCategoryX on AttachmentCategory {
  String get label => switch (this) {
        AttachmentCategory.lessonMaterial => 'Aula',
        AttachmentCategory.activity => 'Atividade',
        AttachmentCategory.slide => 'Slide',
        AttachmentCategory.certificate => 'Certificado',
        AttachmentCategory.document => 'Documento',
        AttachmentCategory.archive => 'Arquivo compactado',
        AttachmentCategory.other => 'Outro',
      };

  bool get supportsDeadline => this == AttachmentCategory.activity;
}
