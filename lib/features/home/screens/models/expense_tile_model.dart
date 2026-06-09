class ExpenseTileModel{
  final int? id;
  final String title;
  final String subtitle;
  final String date;
  final double amount;

  ExpenseTileModel({
    this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount
  });

  factory ExpenseTileModel.fromJson(Map<String,dynamic> json){
    return ExpenseTileModel(
      id : json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      date: json['date'],
      amount: json['amount']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "title" : title,
      "subtitle" : subtitle,
      "date" : date,
      "amount" : amount
    };
  }
}