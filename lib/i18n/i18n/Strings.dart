import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:samples_rabble/i18n/i18n/messages_all.dart';
import 'package:samples_rabble/i18n/i18n/str_model.dart';

class Strings {
  static Future<Strings> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return new Strings();
    });
  }

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  static final Strings instance = new Strings();

  String get title => Intl.message('Flutter Demo Home Page', name: "title");
  String get message =>
      Intl.message('You have pushed the button this many times:',
          name: "message");

  String multiArgs(StrModel args) => Intl.select(
        "一つ目の引数${args.first}は、二つ目の引数は${args.second}",
        name: "multiArgs",
        args: [args],
      );
}
