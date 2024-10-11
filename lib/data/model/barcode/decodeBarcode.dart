class PaymentData {
  final bool success;
  final String barCode;
  final String digitableLine;
  final String dueDate;
  final String assignor;
  final Payer payer;
  final Details details;
  final String amount;

  PaymentData({
    required this.success,
    required this.barCode,
    required this.digitableLine,
    required this.dueDate,
    required this.assignor,
    required this.payer,
    required this.details,
    required this.amount,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      success: json['success'],
      barCode: json['bar_code'],
      digitableLine: json['digitable_line'],
      dueDate: json['due_date'],
      assignor: json['assignor'],
      payer: Payer.fromJson(json['payer']),
      details: Details.fromJson(json['details']),
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'bar_code': barCode,
      'digitable_line': digitableLine,
      'due_date': dueDate,
      'assignor': assignor,
      'payer': payer.toJson(),
      'details': details.toJson(),
      'amount': amount,
    };
  }
}

class Payer {
  final String name;
  final String document;

  Payer({
    required this.name,
    required this.document,
  });

  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      name: json['name'],
      document: json['document'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'document': document,
    };
  }
}

class Details {
  final String originalAmount;
  final String fine;
  final String interest;
  final String discount;
  final String finalAmount;

  Details({
    required this.originalAmount,
    required this.fine,
    required this.interest,
    required this.discount,
    required this.finalAmount,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      originalAmount: json['original_amount'],
      fine: json['fine'],
      interest: json['interest'],
      discount: json['discount'],
      finalAmount: json['final_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original_amount': originalAmount,
      'fine': fine,
      'interest': interest,
      'discount': discount,
      'final_amount': finalAmount,
    };
  }
}