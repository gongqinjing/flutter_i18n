import 'package:flutter/widgets.dart';
import 'package:intl/intl_standalone.dart';

import '../utils/message_printer.dart';

abstract class TranslationLoader {
  static const String LOCALE_SEPARATOR = "_";

  Future<Map> load();

  Locale get locale;

  set locale(Locale locale);

  Future<Locale> findCurrentLocale() async {
    final String systemLocale = await findSystemLocale();
    MessagePrinter.info("The system locale is $systemLocale");
    return _toLocale(systemLocale);
  }

  Locale _toLocale(final String locale) {
    final List<String> systemLocaleSplitted = locale.split(LOCALE_SEPARATOR);
    final bool noCountryCode = systemLocaleSplitted.length == 1;
    final bool hasScriptCode = systemLocaleSplitted.length > 1?(systemLocaleSplitted[1] == 'Hans' || systemLocaleSplitted[1] == 'Hant') : false;
    if (hasScriptCode) {
      return Locale.fromSubtags(
          languageCode: systemLocaleSplitted.first,
          scriptCode: systemLocaleSplitted[1],
          countryCode: systemLocaleSplitted.length == 3?systemLocaleSplitted.last : null);
    } else {
      return Locale(systemLocaleSplitted.first,
          noCountryCode ? null : systemLocaleSplitted.last);
    }
  }
}
