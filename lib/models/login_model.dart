// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  bool status;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.response,
    required this.latLongList,
  });

  Response response;
  LatLongList latLongList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    response: Response.fromJson(json["response"]),
    latLongList: LatLongList.fromJson(json["latLongList"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "latLongList": latLongList.toJson(),
  };
}

class LatLongList {
  LatLongList({
    required this.result,
    required this.id,
    required this.status,
    required this.isCanceled,
    required this.isCompleted,
    required this.isCompletedSuccessfully,
    required this.creationOptions,
    required this.isFaulted,
  });

  List<Result> result;
  int id;
  int status;
  bool isCanceled;
  bool isCompleted;
  bool isCompletedSuccessfully;
  int creationOptions;
  bool isFaulted;

  factory LatLongList.fromJson(Map<String, dynamic> json) => LatLongList(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    id: json["id"],
    status: json["status"],
    isCanceled: json["isCanceled"],
    isCompleted: json["isCompleted"],
    isCompletedSuccessfully: json["isCompletedSuccessfully"],
    creationOptions: json["creationOptions"],
    isFaulted: json["isFaulted"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "id": id,
    "status": status,
    "isCanceled": isCanceled,
    "isCompleted": isCompleted,
    "isCompletedSuccessfully": isCompletedSuccessfully,
    "creationOptions": creationOptions,
    "isFaulted": isFaulted,
  };
}

class Result {
  Result({
    required this.latLongId,
    required this.latitude,
    required this.longitude,
    required this.organizationId,
  });

  String latLongId;
  String latitude;
  String longitude;
  String organizationId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    latLongId: json["latLongId"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    organizationId: json["organizationId"],
  );

  Map<String, dynamic> toJson() => {
    "latLongId": latLongId,
    "latitude": latitude,
    "longitude": longitude,
    "organizationId": organizationId,
  };
}

class Response {
  Response({
    required this.id,
    required this.userId,
    required this.userName,
    required this.roleId,
    required this.employeeId,
    required this.mobileNo,
    required this.email,
    required this.officeType,
    required this.officeId,
    required this.lastLoginDateTime,
    required this.lastLoginIpAddress,
    required this.currentIpAddress,
    required this.currentLoginDateTime,
    required this.role,
    required this.jwtToken,
    required this.refreshToken,
  });

  String id;
  String userId;
  String userName;
  String roleId;
  String employeeId;
  String mobileNo;
  String email;
  String officeType;
  String officeId;
  String lastLoginDateTime;
  String lastLoginIpAddress;
  String currentIpAddress;
  String currentLoginDateTime;
  String role;
  String jwtToken;
  String refreshToken;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    userId: json["userId"],
    userName: json["userName"],
    roleId: json["roleId"],
    employeeId: json["employeeId"],
    mobileNo: json["mobileNo"],
    email: json["email"],
    officeType: json["officeType"],
    officeId: json["officeId"],
    lastLoginDateTime: json["lastLoginDateTime"],
    lastLoginIpAddress: json["lastLoginIPAddress"],
    currentIpAddress: json["currentIPAddress"],
    currentLoginDateTime: json["currentLoginDateTime"],
    role: json["role"],
    jwtToken: json["jwtToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "userName": userName,
    "roleId": roleId,
    "employeeId": employeeId,
    "mobileNo": mobileNo,
    "email": email,
    "officeType": officeType,
    "officeId": officeId,
    "lastLoginDateTime": lastLoginDateTime,
    "lastLoginIPAddress": lastLoginIpAddress,
    "currentIPAddress": currentIpAddress,
    "currentLoginDateTime": currentLoginDateTime,
    "role": role,
    "jwtToken": jwtToken,
    "refreshToken": refreshToken,
  };
}
