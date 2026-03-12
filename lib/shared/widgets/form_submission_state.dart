// Signature: dev.tswicolly03

import '../enums/form_submission_status.dart';

class FormSubmissionState {
  const FormSubmissionState({
    required this.status,
    this.message,
  });

  const FormSubmissionState.idle()
      : status = FormSubmissionStatus.idle,
        message = null;

  const FormSubmissionState.loading()
      : status = FormSubmissionStatus.loading,
        message = null;

  const FormSubmissionState.success([this.message])
      : status = FormSubmissionStatus.success;

  const FormSubmissionState.error(this.message)
      : status = FormSubmissionStatus.error;

  final FormSubmissionStatus status;
  final String? message;

  bool get isLoading => status == FormSubmissionStatus.loading;
  bool get isSuccess => status == FormSubmissionStatus.success;
  bool get isError => status == FormSubmissionStatus.error;

  FormSubmissionState copyWith({
    FormSubmissionStatus? status,
    String? message,
  }) {
    return FormSubmissionState(
      status: status ?? this.status,
      message: message,
    );
  }
}
