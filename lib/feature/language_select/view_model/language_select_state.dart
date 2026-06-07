class LanguageSelectState {
  final int selectedIndex;
  final String selectedLanguage;

  LanguageSelectState({
    required this.selectedIndex,
    required this.selectedLanguage,
  });

  LanguageSelectState copyWith({
    int? selectedIndex,
    String? selectedLanguage,
  }) {
    return LanguageSelectState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}