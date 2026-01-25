class QrModel {
  String? sessionId;
  String? qrCodeData;
  String? qrToken;
  String? expiresAt;

  QrModel({
    this.sessionId,
    this.qrCodeData,
    this.qrToken,
    this.expiresAt,
  });

  /// Calculates the remaining duration until the QR code expires
  Duration get expiryDuration {
    if (expiresAt == null) return const Duration(minutes: 4);
    final expiryTime = DateTime.tryParse(expiresAt!);
    if (expiryTime == null) return const Duration(minutes: 4);
    final remaining = expiryTime.difference(DateTime.now().toUtc());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  factory QrModel.fromJson(Map<String, dynamic> json) {
    return QrModel(
      sessionId: json['sessionId'] as String?,
      qrCodeData: json['qrCodeData'] as String?,
      qrToken: json['qrToken'] as String?,
      expiresAt: json['expiresAt'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'qrToken': qrToken,
    };
  }
}
