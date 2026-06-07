import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Language {
  final String name;
  final String nativeName;
  final IconData icon;

  const Language({
    required this.name,
    required this.nativeName,
    required this.icon,
  });
}


final List<Language> languages = [
    Language(name: 'English', nativeName: 'English', icon: Icons.language),
    Language(name: 'Italian', nativeName: 'Italiano', icon: Icons.language),
    Language(name: 'Spanish', nativeName: 'Espanol', icon: Icons.language),
    Language(name: 'French', nativeName: 'Francais', icon: Icons.language),
    Language(name: 'German', nativeName: 'Deutsch', icon: Icons.language),
    Language(name: 'Japanese', nativeName: 'Japanese', icon: Icons.language),
    Language(name: 'Chinese', nativeName: 'Chinese', icon: Icons.language),
    Language(name: 'Turkish', nativeName: 'Turkce', icon: Icons.language),
  ];


  final staticLanguagesProvider = Provider<List<Language>>((ref) {
    return languages;
  });