import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LanguagePopUpMenu extends ConsumerWidget {
  const LanguagePopUpMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Language language = ref.watch(languageStateProvider);

    return PopupMenuButton<Language>(
      child: Center(child: Text("${AppLocalizations.of(context)!.language}: ${language.flag}")),
      onSelected: (newLanguage) => ref.read(languageStateProvider.notifier).updateLanguage(newLanguage),
      itemBuilder: (context) => Language.values
          .map((Language option) => PopupMenuItem<Language>(
                value: option,
                child: Row(
                  children: [
                    Text(option.flag),
                    const SizedBox(width: 8.0),
                    Text(option.name),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
