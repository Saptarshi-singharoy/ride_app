class OnBehalfModel {
  OnBehalfModel(
      {required this.nameOfGuest,
      required this.guestType,
      required this.from,
      required this.date,
      required this.to,
      required this.purpose,
      required this.ex1,
      required this.ex2,
      required this.ex3,
      required this.ex4});

  final String nameOfGuest;
  final String guestType;
  final String from;
  final String to;
  final String purpose;
  final String date;
  final String ex1;
  final String ex2;
  final String ex3;
  final String ex4;

  factory OnBehalfModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'nameOfGuest': String nameOfGuest,
        'guestType': String guestType,
        'from': String from,
        'to': String to,
        'purpose': String purpose,
        'date': String date,
        'ex1': String ex1,
        'ex2': String ex2,
        'ex3': String ex3,
        'ex4': String ex4,
      } =>
        OnBehalfModel(
            nameOfGuest: nameOfGuest,
            guestType: guestType,
            from: from,
            to: to,
            purpose: purpose,
            date: date,
            ex1: ex1,
            ex2: ex2,
            ex3: ex3,
            ex4: ex4),
      _ => throw FormatException('wrong format')
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'nameOfGuest': nameOfGuest,
      'guestType': guestType,
      'from': from,
      'to': to,
      'purpose': purpose,
      'ex1': ex1,
      'ex2': ex2,
      'ex3': ex3,
      'ex4': ex4,
    };
  }
}
