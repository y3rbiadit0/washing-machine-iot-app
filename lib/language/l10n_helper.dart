import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextHelper on BuildContext {
  AppLocalizations? get l10n {
    return AppLocalizations.of(this);
  }
}
