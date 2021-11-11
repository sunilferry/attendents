// To parse this JSON data, do
//
//     final salaryListResponse = salaryListResponseFromJson(jsonString);

import 'dart:convert';

SalaryListResponse salaryListResponseFromJson(String str) => SalaryListResponse.fromJson(json.decode(str));

String salaryListResponseToJson(SalaryListResponse data) => json.encode(data.toJson());

class SalaryListResponse {
  SalaryListResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  bool status;
  List<Datum> data;

  factory SalaryListResponse.fromJson(Map<String, dynamic> json) => SalaryListResponse(
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.employeeId,
    required this.wagesId,
    required this.agreementNo,
    required this.month,
    required this.year,
    required this.name,
    required this.mobile,
    required this.category,
    required this.pasentDays,
    required this.basicWages,
    required this.miss,
    required this.epfAmount,
    required this.epftrrnNo,
    required this.epfDate,
    required this.esiAmount,
    required this.esiChallanNo,
    required this.esiDate,
    required this.amountPaidtoOutsource,
    required this.paymentMode,
    required this.paymentDate,
  });

  String employeeId;
  String wagesId;
  String agreementNo;
  String month;
  String year;
  String name;
  String mobile;
  String category;
  String pasentDays;
  String basicWages;
  String miss;
  String epfAmount;
  String epftrrnNo;
  String epfDate;
  String esiAmount;
  String esiChallanNo;
  String esiDate;
  String amountPaidtoOutsource;
  String paymentMode;
  String paymentDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    employeeId: json["employeeId"],
    wagesId: json["wagesId"],
    agreementNo: json["agreementNo"],
    month: json["month"],
    year: json["year"],
    name: json["name"],
    mobile: json["mobile"],
    category: json["category"],
    pasentDays: json["pasentDays"],
    basicWages: json["basicWages"],
    miss: json["miss"],
    epfAmount: json["epfAmount"],
    epftrrnNo: json["epftrrnNo"],
    epfDate: json["epfDate"],
    esiAmount: json["esiAmount"],
    esiChallanNo: json["esiChallanNo"],
    esiDate: json["esiDate"],
    amountPaidtoOutsource: json["amountPaidtoOutsource"],
    paymentMode: json["paymentMode"],
    paymentDate: json["paymentDate"],
  );

  Map<String, dynamic> toJson() => {
    "employeeId": employeeId,
    "wagesId": wagesId,
    "agreementNo": agreementNo,
    "month": month,
    "year": year,
    "name": name,
    "mobile": mobile,
    "category": category,
    "pasentDays": pasentDays,
    "basicWages": basicWages,
    "miss": miss,
    "epfAmount": epfAmount,
    "epftrrnNo": epftrrnNo,
    "epfDate": epfDate,
    "esiAmount": esiAmount,
    "esiChallanNo": esiChallanNo,
    "esiDate": esiDate,
    "amountPaidtoOutsource": amountPaidtoOutsource,
    "paymentMode": paymentMode,
    "paymentDate": paymentDate,
  };
}
