import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum CourseSubjectType {
  mandatory,
  elective,
  internship,
  extension,
  thesis,
}

extension CourseSubjectTypeX on CourseSubjectType {
  String get label => switch (this) {
        CourseSubjectType.mandatory => 'Obrigatoria',
        CourseSubjectType.elective => 'Optativa',
        CourseSubjectType.internship => 'Estagio',
        CourseSubjectType.extension => 'Extensao',
        CourseSubjectType.thesis => 'TCC',
      };
}

@JsonEnum(fieldRename: FieldRename.snake)
enum CourseSubjectStatus {
  notStarted,
  inProgress,
  completed,
  failed,
  dropped,
}

extension CourseSubjectStatusX on CourseSubjectStatus {
  String get label => switch (this) {
        CourseSubjectStatus.notStarted => 'Nao iniciada',
        CourseSubjectStatus.inProgress => 'Cursando',
        CourseSubjectStatus.completed => 'Concluida',
        CourseSubjectStatus.failed => 'Reprovada',
        CourseSubjectStatus.dropped => 'Trancada',
      };
}

@JsonEnum(fieldRename: FieldRename.snake)
enum ValidationStatus {
  pending,
  submitted,
  approved,
  rejected,
}

extension ValidationStatusX on ValidationStatus {
  String get label => switch (this) {
        ValidationStatus.pending => 'Pendente',
        ValidationStatus.submitted => 'Enviado',
        ValidationStatus.approved => 'Validado',
        ValidationStatus.rejected => 'Recusado',
      };
}

@JsonEnum(fieldRename: FieldRename.snake)
enum InternshipStatus {
  planned,
  inProgress,
  completed,
  interrupted,
}

extension InternshipStatusX on InternshipStatus {
  String get label => switch (this) {
        InternshipStatus.planned => 'Planejado',
        InternshipStatus.inProgress => 'Em andamento',
        InternshipStatus.completed => 'Concluido',
        InternshipStatus.interrupted => 'Interrompido',
      };
}

@JsonEnum(fieldRename: FieldRename.snake)
enum StudyTopicStatus {
  notStarted,
  studying,
  completed,
}

extension StudyTopicStatusX on StudyTopicStatus {
  String get label => switch (this) {
        StudyTopicStatus.notStarted => 'Nao iniciado',
        StudyTopicStatus.studying => 'Estudando',
        StudyTopicStatus.completed => 'Concluido',
      };
}

@JsonEnum(fieldRename: FieldRename.snake)
enum StudyTaskPriority {
  low,
  medium,
  high,
}

extension StudyTaskPriorityX on StudyTaskPriority {
  String get label => switch (this) {
        StudyTaskPriority.low => 'Baixa',
        StudyTaskPriority.medium => 'Media',
        StudyTaskPriority.high => 'Alta',
      };
}

@JsonEnum(fieldRename: FieldRename.snake)
enum StudyTaskStatus {
  pending,
  inProgress,
  done,
  canceled,
}

extension StudyTaskStatusX on StudyTaskStatus {
  String get label => switch (this) {
        StudyTaskStatus.pending => 'Pendente',
        StudyTaskStatus.inProgress => 'Em andamento',
        StudyTaskStatus.done => 'Concluida',
        StudyTaskStatus.canceled => 'Cancelada',
      };
}
