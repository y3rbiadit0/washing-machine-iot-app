import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language.g.dart';

enum Language {
  english(flag: "🇺🇸", name: "English", code: "en"),
  italian(flag: "🇮🇹", name: "Italiano", code: "it"),
  spanish(flag: "🇦🇷", name: "Español", code: "es");

  const Language({required this.flag, required this.name, required this.code});

  final String flag;
  final String name;
  final String code;
}

@riverpod
class LanguageState extends _$LanguageState {
  @override
  Language build() => Language.english;

  void updateLanguage(Language language) => state = language;
}
