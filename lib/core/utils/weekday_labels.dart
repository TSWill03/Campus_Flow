// Signature: dev.tswicolly03

class WeekdayLabels {
  static const Map<int, String> long = {
    1: 'Segunda-feira',
    2: 'Terca-feira',
    3: 'Quarta-feira',
    4: 'Quinta-feira',
    5: 'Sexta-feira',
    6: 'Sabado',
    7: 'Domingo',
  };

  static const Map<int, String> short = {
    1: 'Seg',
    2: 'Ter',
    3: 'Qua',
    4: 'Qui',
    5: 'Sex',
    6: 'Sab',
    7: 'Dom',
  };

  static String? longLabel(int? weekday) => long[weekday];

  static String? shortLabel(int? weekday) => short[weekday];
}
