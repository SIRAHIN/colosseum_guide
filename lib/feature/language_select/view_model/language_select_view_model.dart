import 'package:colosseum_guide/feature/language_select/data/local_language_data/local_language_data.dart';
import 'package:colosseum_guide/feature/language_select/view_model/language_select_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class LanguageSelectViewModel extends Notifier<LanguageSelectState>{
  @override
  LanguageSelectState build() {
    getLanguage();
    return LanguageSelectState(selectedIndex: 0, selectedLanguage: '');
  }

  Future<void> getLanguage() async {
    final language = await ref.read(localLanguageDataProvider).getLanguage();
    if (language.isLanguageSelected) {
      state = state.copyWith(selectedIndex: language.selectedIndex, selectedLanguage: language.selectedLanguage);
    } else {
      state = state.copyWith(selectedIndex: 0, selectedLanguage: '');
    }
  }

  void selectLanguage({required int index, required String language, required bool isLanguageSelected}) {
    state = state.copyWith(selectedIndex: index, selectedLanguage: language);
    ref.read(localLanguageDataProvider).saveLanguage(language: language, index: index, isLanguageSelected: isLanguageSelected)  ;
  }

}

final languageSelectViewModelProvider = NotifierProvider<LanguageSelectViewModel, LanguageSelectState>(
  () => LanguageSelectViewModel(),
);