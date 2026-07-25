import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// Persists onboarding state across launches.
/// - `languageSelected`: user has chosen a language (auto-set to English on first launch)
/// - `audioDownloaded`: all audio tracks are downloaded
class OnboardingCache {
  static const _boxName = 'onboarding_box';
  static const _languageKey = 'language_selected';
  static const _downloadKey = 'audio_downloaded';

  Future<Box<bool>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<bool>(_boxName);
    }
    return Hive.box<bool>(_boxName);
  }

  Future<bool> isLanguageSelected() async {
    final box = await _openBox();
    return box.get(_languageKey, defaultValue: false) ?? false;
  }

  Future<bool> isAudioDownloaded() async {
    final box = await _openBox();
    return box.get(_downloadKey, defaultValue: false) ?? false;
  }

  Future<void> setLanguageSelected() async {
    final box = await _openBox();
    await box.put(_languageKey, true);
  }

  Future<void> setAudioDownloaded(bool value) async {
    final box = await _openBox();
    await box.put(_downloadKey, value);
  }

  Future<void> reset() async {
    final box = await _openBox();
    await box.clear();
  }
}

final onboardingCacheProvider = Provider<OnboardingCache>((ref) {
  return OnboardingCache();
});
