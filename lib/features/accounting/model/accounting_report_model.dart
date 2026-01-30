class AccountingReportModel {
  final String title;
  final String date;
  final String type;

  AccountingReportModel({
    required this.title,
    required this.date,
    this.type = 'PDF',
  });
}
