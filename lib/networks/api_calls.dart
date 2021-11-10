import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:updgme_app/models/attendant_list_model.dart';
import 'package:updgme_app/models/login_model.dart';
import 'package:updgme_app/models/profile_model.dart';

class ApiCalls {
  static const String baseUrl = 'http://janshakti.upsdc.gov.in/api/';
  static ApiCalls? apiCalls;

  static ApiCalls getInstance() {
    if (apiCalls == null) {
      apiCalls = ApiCalls();
    }
    return apiCalls!;
  }



  Future<LoginResponse?> login(final requestParam) async {

    final header = {
      'Content-Type': 'application/json'
    };
    try {
      final req = json.encode(requestParam);
      print(req);
      final res = await http.post(
          Uri.parse(baseUrl + "userapi/Authenticate"),
          body: req,
          headers: header);
      print(res.body);
      if(res.body==null){
        return null;
      }
      if (res.statusCode == 200) {
        return loginResponseFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<ProfileResponse?> getProfile(String token) async {
    final header = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer ' + token
    };
    try {
      final res = await http.get(
          Uri.parse(baseUrl + "AttendanceApi/GetProfile"),
          headers: header);
      print(res.body);
      if (res.statusCode == 200) {
        return profileResponseFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<AttendantListResponse?> getAttendants(final requestParam, String token) async {
    final header = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer ' + token
    };
    try {
      final res = await http.post(
          Uri.parse(baseUrl + "AttendanceApi/GetAttendanceList"),
          body: jsonEncode(requestParam),
          headers: header);
      print(res.body);
      if (res.statusCode == 200) {
        return attendantListResponseFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

}
