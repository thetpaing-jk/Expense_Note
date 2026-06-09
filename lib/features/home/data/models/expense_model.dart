class ExpenseModel {
  final int? id;
  final String title;
  final String subtitle;
  final double amount;
  final String date;

  ExpenseModel({
    this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date, 
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "subtitle" : subtitle,
      "amount": amount,
      "date": date,
    };
  }

  ExpenseModel copyWith({
    String? title,
    double? amount,
    String? date,
    String? subtitle,
  }) {
    return ExpenseModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
