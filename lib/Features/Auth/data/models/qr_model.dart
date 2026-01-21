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