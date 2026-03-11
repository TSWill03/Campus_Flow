import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_providers.dart';
import 'app_color_profile.dart';

class ColorProfileController extends Notifier<AppColorProfile> {
  static const _key = 'app_color_profile';

  @override
  AppColorProfile build() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    final rawValue = sharedPreferences.getString(_key);

    if (rawValue == null || rawValue.isEmpty) {
      return AppColorProfile.defaultProfile;
    }

    try {
      return AppColorProfile.fromStorageString(rawValue);
    } catch (_) {
      return AppColorProfile.defaultProfile;
    }
  }

  Future<void> updateProfile(AppColorProfile profile) async {
    state = profile;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, profile.toStorageString());
  }

  Future<void> reset() => updateProfile(AppColorProfile.defaultProfile);
}

final colorProfileControllerProvider =
    NotifierProvider<ColorProfileController, AppColorProfile>(
  ColorProfileController.new,
);
