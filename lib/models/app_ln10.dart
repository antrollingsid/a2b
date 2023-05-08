import 'package:l10n_flutter/l10n_core.dart';

// Supported locales
const l10nSettings =
  L10nSettings(path: 'lib/l10n', locales: [
  L10nLocale('en', 'US', 'English, (US)'),
  L10nLocale('es', 'ES', 'Spanish'),
  L10nLocale('tr', 'TR', 'Turkish'), 
]);

@l10nSettings
class L10n {
  static const truck = L10nSet('app_gretting', 'Hello');     
}
