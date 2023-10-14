import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataModel {


  final int id;
  final String employeeNo;
  final String employeeIDCard;
  final String employeeTitleName;
  final String employeeMobileNo;
  final String employeeEmail;
  DataModel({
    required this.id,
    required this.employeeNo,
    required this.employeeIDCard,
    required this.employeeTitleName,
    required this.employeeMobileNo,
    required this.employeeEmail,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeNo': employeeNo,
      'employeeIDCard': employeeIDCard,
      'employeeTitleName': employeeTitleName,
      'employeeMobileNo': employeeMobileNo,
      'employeeEmail': employeeEmail,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: (map['id'] ?? 0) as int,
      employeeNo: (map['employeeNo'] ?? '') as String,
      employeeIDCard: (map['employeeIDCard'] ?? '') as String,
      employeeTitleName: (map['employeeTitleName'] ?? '') as String,
      employeeMobileNo: (map['employeeMobileNo'] ?? '') as String,
      employeeEmail: (map['employeeEmail'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) => DataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
