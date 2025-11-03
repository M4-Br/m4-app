class PixScheduledResponse {
  final bool success;
  final List<PixScheduled> data;
  final int count;

  PixScheduledResponse({
    required this.success,
    required this.data,
    required this.count,
  });

  factory PixScheduledResponse.fromJson(Map<String, dynamic> json) {
    return PixScheduledResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PixScheduled.fromJson(e))
          .toList() ??
          [],
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
      'count': count,
    };
  }
}

class PixScheduled {
  final String id;
  final DateTime scheduledDate;
  final String accountId;
  final String pixDate;
  final double amount;
  final int counterpartyBankId;
  final String counterpartyIspbId;
  final int counterpartyBranchId;
  final String counterpartyAccount;
  final String counterpartyAccountType;
  final String counterpartyName;
  final String counterpartyPersonType;
  final String counterpartyDocument;
  final String counterpartyKeyType;
  final String counterpartyKey;
  final String observation;
  final String status;
  final bool generatedRecurrence;
  final String recurrencePixId;
  final int recurrenceSequence;
  final String occurrence;
  final String launchId;
  final DateTime? cancellationDate;
  final DateTime? processingDate;

  PixScheduled({
    required this.id,
    required this.scheduledDate,
    required this.accountId,
    required this.pixDate,
    required this.amount,
    required this.counterpartyBankId,
    required this.counterpartyIspbId,
    required this.counterpartyBranchId,
    required this.counterpartyAccount,
    required this.counterpartyAccountType,
    required this.counterpartyName,
    required this.counterpartyPersonType,
    required this.counterpartyDocument,
    required this.counterpartyKeyType,
    required this.counterpartyKey,
    required this.observation,
    required this.status,
    required this.generatedRecurrence,
    required this.recurrencePixId,
    required this.recurrenceSequence,
    required this.occurrence,
    required this.launchId,
    this.cancellationDate,
    this.processingDate,
  });

  factory PixScheduled.fromJson(Map<String, dynamic> json) {
    return PixScheduled(
      id: json['id'] ?? '',
      scheduledDate: DateTime.parse(json['scheduledDate']),
      accountId: json['accountId'] ?? '',
      pixDate: json['pixDate'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      counterpartyBankId: json['counterpartyBankId'] ?? 0,
      counterpartyIspbId: json['counterpartyIspbId'] ?? '',
      counterpartyBranchId: json['counterpartyBranchId'] ?? 0,
      counterpartyAccount: json['counterpartyAccount'] ?? '',
      counterpartyAccountType: json['counterpartyAccountType'] ?? '',
      counterpartyName: json['counterpartyName'] ?? '',
      counterpartyPersonType: json['counterpartyPersonType'] ?? '',
      counterpartyDocument: json['counterpartyDocument'] ?? '',
      counterpartyKeyType: json['counterpartyKeyType'] ?? '',
      counterpartyKey: json['counterpartyKey'] ?? '',
      observation: json['observation'] ?? '',
      status: json['status'] ?? '',
      generatedRecurrence: json['generatedRecurrence'] ?? false,
      recurrencePixId: json['recurrencePixId'] ?? '',
      recurrenceSequence: json['recurrenceSequence'] ?? 0,
      occurrence: json['occurrence'] ?? '',
      launchId: json['launchId'] ?? '',
      cancellationDate: json['cancellationDate'] != null
          ? DateTime.tryParse(json['cancellationDate'])
          : null,
      processingDate: json['processingDate'] != null
          ? DateTime.tryParse(json['processingDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduledDate': scheduledDate.toIso8601String(),
      'accountId': accountId,
      'pixDate': pixDate,
      'amount': amount,
      'counterpartyBankId': counterpartyBankId,
      'counterpartyIspbId': counterpartyIspbId,
      'counterpartyBranchId': counterpartyBranchId,
      'counterpartyAccount': counterpartyAccount,
      'counterpartyAccountType': counterpartyAccountType,
      'counterpartyName': counterpartyName,
      'counterpartyPersonType': counterpartyPersonType,
      'counterpartyDocument': counterpartyDocument,
      'counterpartyKeyType': counterpartyKeyType,
      'counterpartyKey': counterpartyKey,
      'observation': observation,
      'status': status,
      'generatedRecurrence': generatedRecurrence,
      'recurrencePixId': recurrencePixId,
      'recurrenceSequence': recurrenceSequence,
      'occurrence': occurrence,
      'launchId': launchId,
      'cancellationDate': cancellationDate?.toIso8601String(),
      'processingDate': processingDate?.toIso8601String(),
    };
  }
}
