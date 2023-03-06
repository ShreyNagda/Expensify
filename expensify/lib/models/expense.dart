class Expense {
  String? id;
  String? userid;
  double? amount;
  String? description;
  String? category;
  DateTime? date;

  Expense(
      {this.id,
      this.userid,
      this.amount,
      this.description,
      this.category,
      this.date});
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
        id: map['id'],
        userid: map['userid'],
        amount: double.parse(map['amount']),
        description: map['description'],
        category: map['category'],
        date: DateTime.tryParse(map['date']));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date!.toIso8601String()
    };
  }
}
