enum TransactionType { income, expense }

class AppTransaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category;

  AppTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
        'type': type == TransactionType.income ? 'income' : 'expense',
        'category': category,
      };

  factory AppTransaction.fromMap(Map<String, dynamic> map) => AppTransaction(
        id: map['id'],
        title: map['title'],
        amount: map['amount'],
        date: DateTime.parse(map['date']),
        type: map['type'] == 'income'
            ? TransactionType.income
            : TransactionType.expense,
        category: map['category'],
      );
}
