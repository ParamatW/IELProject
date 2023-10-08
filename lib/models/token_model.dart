import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TokenModel {
  final int userId;
  final int employeeId;
  final String employeeNo;
  final String refreshToken;
  final String accessToken;
  final String expiredDt;
  TokenModel({
    required this.userId,
    required this.employeeId,
    required this.employeeNo,
    required this.refreshToken,
    required this.accessToken,
    required this.expiredDt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'employeeId': employeeId,
      'employeeNo': employeeNo,
      'refreshToken': refreshToken,
      'accessToken': accessToken,
      'expiredDt': expiredDt,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      userId: (map['userId'] ?? 0) as int,
      employeeId: (map['employeeId'] ?? 0) as int,
      employeeNo: (map['employeeNo'] ?? '') as String,
      refreshToken: (map['refreshToken'] ?? '') as String,
      accessToken: (map['accessToken'] ?? '') as String,
      expiredDt: (map['expiredDt'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}