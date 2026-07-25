import 'package:colosseum_guide/feature/language_select/model/language_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

abstract class LocalLanguageData {
  Box<LanguageModel> get languageBox;
  LanguageModel saveLanguage({
    required String language,
    required int index,
    required bool isLanguageSelected,
  });
  LanguageModel getLanguage();
}

class LocalLanguageDataImpl implements LocalLanguageData {
  static const String _boxName = 'language_box';
  static const String _languageKey = 'language';

  @override
  Box<LanguageModel> get languageBox => Hive.box<LanguageModel>(_boxName);

  @override
  LanguageModel saveLanguage({
    required String language,
    required int index,
    required bool isLanguageSelected,
  }) {
    final languageModel = LanguageModel(
      selectedLanguage: language,
      selectedIndex: index,
      isLanguageSelected: isLanguageSelected,
    );
    languageBox.put(_languageKey, languageModel);
    return languageModel;
  }

  @override
  LanguageModel getLanguage() {
    final language = languageBox.get(_languageKey);
    if (language != null && language.selectedLanguage.isNotEmpty) {
      return language;
    }
    return LanguageModel(
      selectedLanguage: 'English',
      selectedIndex: 0,
      isLanguageSelected: true,
    );
  }
}

final localLanguageDataProvider = Provider<LocalLanguageData>((ref) {
  return LocalLanguageDataImpl();
});
