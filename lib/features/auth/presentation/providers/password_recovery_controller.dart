// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/auth_action_result.dart';
import 'auth_providers.dart';

class PasswordRecoveryController
    extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<AuthActionResult?> resetWithRecoveryCode({
    required String email,
    required String recoveryCode,
    required String newPassword,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final result = await ref
          .read(authRepositoryProvider)
          .resetPasswordWithRecoveryCode(
            email: email,
            recoveryCode: recoveryCode,
            newPassword: newPassword,
          );
      await ref.read(authControllerProvider.notifier).refresh();
      state = FormSubmissionState.success(result.message);
      return result;
    } catch (error) {
      state = FormSubmissionState.error(
        error is AppException
            ? error.message
            : 'Nao foi possivel redefinir a senha: $error',
      );
      return null;
    }
  }

  Future<AuthActionResult?> resetWithGoogle({
    required String email,
    required String newPassword,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final result = await ref.read(authRepositoryProvider).resetPasswordWithGoogle(
            email: email,
            newPassword: newPassword,
          );
      await ref.read(authControllerProvider.notifier).refresh();
      state = FormSubmissionState.success(result.message);
      return result;
    } catch (error) {
      state = FormSubmissionState.error(
        error is AppException
            ? error.message
            : 'Nao foi possivel redefinir a senha com Google: $error',
      );
      return null;
    }
  }
}

final passwordRecoveryControllerProvider =
    NotifierProvider.autoDispose<
      PasswordRecoveryController,
      FormSubmissionState
    >(PasswordRecoveryController.new);
