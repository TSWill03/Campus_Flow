import 'package:intl/intl.dart';

class AppFormatters {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final DateFormat _dateTimeFormat =
      DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');
  static final NumberFormat _decimalFormat =
      NumberFormat.decimalPattern('pt_BR');
  static final NumberFormat _hoursFormat = NumberFormat('0.##', 'pt_BR');

  static String formatDate(DateTime? date) {
    if (date == null) {
      return '-';
    }
    return _dateFormat.format(date);
  }

  static String formatHours(int value) => '${_decimalFormat.format(value)} h';

  static String formatLessonHours(double value) =>
      '${_hoursFormat.format(value)} h';

  static String formatDateTime(DateTime? date) {
    if (date == null) {
      return '-';
    }
    return _dateTimeFormat.format(date);
  }

  static String formatPercent(double value) =>
      '${value.toStringAsFixed(0).replaceAll('.', ',')}%';

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}min';
  }
}
