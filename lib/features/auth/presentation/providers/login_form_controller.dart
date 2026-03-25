// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/auth_action_result.dart';
import 'auth_providers.dart';

class LoginFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<AuthActionResult?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final result = await ref.read(authRepositoryProvider).signInWithPassword(
            email: email,
            password: password,
          );
      await ref.read(authControllerProvider.notifier).refresh();
      state = FormSubmissionState.success(result.message);
      return result;
    } catch (error) {
      state = FormSubmissionState.error(
        error is AppException
            ? error.message
            : 'Nao foi possivel entrar: $error',
      );
      return null;
    }
  }

  Future<AuthActionResult?> register({
    required String displayName,
    required String email,
    required String password,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final result = await ref.read(authRepositoryProvider).registerWithPassword(
            displayName: displayName,
            email: email,
            password: password,
          );
      await ref.read(authControllerProvider.notifier).refresh();
      state = FormSubmissionState.success(result.message);
      return result;
    } catch (error) {
      state = FormSubmissionState.error(
        error is AppException
            ? error.message
            : 'Nao foi possivel criar a conta: $error',
      );
      return null;
    }
  }

  Future<AuthActionResult?> signInWithGoogle() async {
    state = const FormSubmissionState.loading();

    try {
      final result = await ref.read(authRepositoryProvider).signInWithGoogle();
      await ref.read(authControllerProvider.notifier).refresh();
      state = FormSubmissionState.success(result.message);
      return result;
    } catch (error) {
      state = FormSubmissionState.error(
        error is AppException
            ? error.message
            : 'Nao foi possivel entrar com Google: $error',
      );
      return null;
    }
  }
}

final loginFormControllerProvider =
    NotifierProvider.autoDispose<LoginFormController, FormSubmissionState>(
      LoginFormController.new,
    );
