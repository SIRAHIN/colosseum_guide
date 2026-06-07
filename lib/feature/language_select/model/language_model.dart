import 'package:hive/hive.dart';

part 'language_model.g.dart';

@HiveType(typeId: 0)
class LanguageModel extends HiveObject {
  @HiveField(0)
  final String selectedLanguage;

  @HiveField(1)
  final int selectedIndex;

  @HiveField(2)
  final bool isLanguageSelected;

  LanguageModel({
    required this.selectedLanguage,
    required this.selectedIndex,
    required this.isLanguageSelected,
  });
}