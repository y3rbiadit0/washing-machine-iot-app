import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'language/language.dart';
import 'language/language_pop_up_menu.dart';

part 'main.g.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello world two';
}

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: HomePage(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final String value = ref.watch(helloWorldProvider);
    final language = ref.watch(languageStateProvider);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(language.code),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Title"),
          actions: const [LanguagePopUpMenu()],
        ),
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
