class SettlementModel {
  final String id;
  final String cafeId;
  final int totalSales;
  final int platformFee;
  final int netAmount;
  final DateTime startDate;
  final DateTime endDate;
  final SettlementStatus status;
  final DateTime createdAt;
  final DateTime? paidAt;

  SettlementModel({
    required this.id,
    required this.cafeId,
    required this.totalSales,
    required this.platformFee,
    required this.netAmount,
    required this.startDate,
    required this.endDate,
    this.status = SettlementStatus.pending,
    required this.createdAt,
    this.paidAt,
  });
}

enum SettlementStatus {
  pending,
  approved,
  paid;

  static SettlementStatus fromString(String value) {
    return SettlementStatus.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => SettlementStatus.pending);
  }
}
