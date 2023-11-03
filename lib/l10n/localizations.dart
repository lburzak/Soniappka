import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationsGetter on BuildContext {
  AppLocalizations get l10n {
    final localizations = AppLocalizations.of(this);

    if (localizations == null) {
      throw Exception("Localizations not provided");
    }

    return localizations;
  }
}
