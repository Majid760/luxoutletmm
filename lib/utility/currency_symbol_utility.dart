import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// localization
currency(BuildContext context) {
  Locale locale = Localizations.localeOf(context);
  var format =
      NumberFormat.simpleCurrency(locale: locale.toString(), name: 'GBP');
  return format.currencySymbol;
}
