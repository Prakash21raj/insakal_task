class OtpModel {
  final int userId;
  final String otp;
  final String platform;

  OtpModel({required this.userId, required this.otp, required this.platform});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'otp': otp,
      'platform': platform,
    };
  }
}