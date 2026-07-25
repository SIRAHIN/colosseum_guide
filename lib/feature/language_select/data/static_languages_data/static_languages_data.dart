import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Language {
  final String name;
  final String nativeName;
  final IconData icon;
  final bool isAvailable;
  final String flag;
  final String code;

  const Language({
    required this.name,
    required this.nativeName,
    this.icon = Icons.language_rounded,
    required this.isAvailable,
    required this.flag,
    required this.code,
  });
}

final List<Language> languages = const [
  Language(
    name: 'English',
    nativeName: 'English',
    icon: Icons.language_rounded,
    isAvailable: true,
    flag: '🇬🇧',
    code: 'EN',
  ),
  Language(
    name: 'Italian',
    nativeName: 'Italiano',
    icon: Icons.language_rounded,
    isAvailable: false,
    flag: '🇮🇹',
    code: 'IT',
  ),
  Language(
    name: 'Spanish',
    nativeName: 'Español',
    icon: Icons.language_rounded,
    isAvailable: false,
    flag: '🇪🇸',
    code: 'ES',
  ),
  Language(
    name: 'French',
    nativeName: 'Français',
    icon: Icons.language_rounded,
    isAvailable: false,
    flag: '🇫🇷',
    code: 'FR',
  ),
  Language(
    name: 'German',
    nativeName: 'Deutsch',
    icon: Icons.language_rounded,
    isAvailable: false,
    flag: '🇩🇪',
    code: 'DE',
  ),
  Language(
    name: 'Japanese',
    nativeName: '日本語',
    icon: Icons.language_rounded,
    isAvailable: false,
    flag: '🇯🇵',
    code: 'JA',
  ),
  Language(
    name: 'Chinese',
    nativeName: '中文',
    icon: Icons.language_rounded,
    isAvailable: false,
    flag: '🇨🇳',
    code: 'ZH',
  ),
  Language(
    name: 'Turkish',
    nativeName: 'Türkçe',
    icon: Icons.language_rounded,
    isAvailable: false,
    flag: '🇹🇷',
    code: 'TR',
  ),
];

final staticLanguagesProvider = Provider<List<Language>>((ref) {
  return languages;
});