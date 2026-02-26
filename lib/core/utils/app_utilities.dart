import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

abstract class AppUtilities {
  AppUtilities._();

  static String getCurrencySymbol(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencySymbol;
  }
}
