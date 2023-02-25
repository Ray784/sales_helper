class Account {
  final int? id;
  final DateTime dateTime;
  final double amount;
  final bool isPurchase;
  String description;

  Account(
      {this.id,
      required this.dateTime,
      required this.amount,
      required this.isPurchase,
      this.description = ""}) {
    if (description == "") {
      description =
          isPurchase ? "Purchases: No Description" : "Sales: No Description";
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'dateTime': dateTime.toIso8601String(),
      'amount': amount,
      'isPurchase': isPurchase ? 1 : 0,
      'description': description
    };
    if (id != null) map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return "{id: $id, dateTime: ${dateTime.toIso8601String()}, amount: $amount, isPurchase: $isPurchase, description: $description}";
  }

  static List<Account> toAccount(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (index) {
      return Account(
          id: maps[index]['id'],
          dateTime: DateTime.parse(maps[index]['dateTime']),
          amount: maps[index]['amount'],
          isPurchase: maps[index]['isPurchase'] == 1 ? true : false,
          description: maps[index]['description']);
    });
  }
}
