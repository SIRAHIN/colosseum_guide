import 'package:colosseum_guide/feature/language_select/model/language_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

abstract class LocalLanguageData {
  Box<LanguageModel> get languageBox;
  Future<LanguageModel> saveLanguage({
    required String language,
    required int index,
    required bool isLanguageSelected,
  });
  Future<LanguageModel> getLanguage();
}

class LocalLanguageDataImpl implements LocalLanguageData {
  static const String _boxName = 'language_box';
  static const String _languageKey = 'language';

  @override
  Box<LanguageModel> get languageBox => Hive.box<LanguageModel>(_boxName);

  @override
  Future<LanguageModel> saveLanguage({
    required String language,
    required int index,
    required bool isLanguageSelected,
  }) async {
    final languageModel = LanguageModel(
      selectedLanguage: language,
      selectedIndex: index,
      isLanguageSelected: isLanguageSelected,
    );
    await languageBox.put(_languageKey, languageModel);
    return languageModel;
  }

  @override
  Future<LanguageModel> getLanguage() async {
    return languageBox.get(_languageKey) ??
        LanguageModel(
          selectedLanguage: '',
          selectedIndex: 0,
          isLanguageSelected: false,
        );
  }
}

final localLanguageDataProvider = Provider<LocalLanguageData>((ref) {
  return LocalLanguageDataImpl();
});
