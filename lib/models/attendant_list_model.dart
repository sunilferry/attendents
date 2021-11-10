// To parse this JSON data, do
//
//     final attendantListResponse = attendantListResponseFromJson(jsonString);

import 'dart:convert';

AttendantListResponse attendantListResponseFromJson(String str) => AttendantListResponse.fromJson(json.decode(str));

String attendantListResponseToJson(AttendantListResponse data) => json.encode(data.toJson());

class AttendantListResponse {
  AttendantListResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  bool status;
  List<Datum> data;

  factory AttendantListResponse.fromJson(Map<String, dynamic> json) => AttendantListResponse(
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
    required this.attendanceType,
    required this.latitude,
    required this.longitude,
    required this.attendanceDate,
    required this.employeeName,
    required this.imageUrl,
  });

  String attendanceType;
  String latitude;
  String longitude;
  String attendanceDate;
  String employeeName;
  String imageUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    attendanceType: json["attendanceType"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    attendanceDate: json["attendanceDate"],
    employeeName: json["employeeName"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "attendanceType": attendanceType,
    "latitude": latitude,
    "longitude": longitude,
    "attendanceDate": attendanceDate,
    "employeeName": employeeName,
    "imageUrl": imageUrl,
  };
}
