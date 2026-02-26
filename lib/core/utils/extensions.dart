import 'package:intl/intl.dart';

extension NumberExtension on num {
  String toCompactNumber() {
    return NumberFormat.compact(locale: 'th_TH').format(this);
  }

  String toCurrency({String? locale = 'th_TH'}) {
    return NumberFormat.simpleCurrency(locale: locale).format(this);
  }
}
