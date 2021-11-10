import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static SharedPreferences? prefs;
  static PrefManager? prefManager;


  static Future<PrefManager> getInstance() async {
    if(prefs==null){
      prefs = await SharedPreferences.getInstance();
    }

    if(prefManager==null){
      prefManager=PrefManager();
    }
    return prefManager!;
  }



  dynamic setEmail(String email) async {
    return prefs!.setString('email', email);
  }

  String getEmail() {
    return prefs!.getString('email') ?? '';
  }

  dynamic setId(String id) async {
    return prefs!.setString('id', id);
  }

  String getId() {
    return prefs!.getString('id') ?? '';
  }
  dynamic setToken(String token) async {
    return prefs!.setString('token', token);
  }

  String getToken() {
    return prefs!.getString('token') ?? '';
  }
  dynamic setName(String name) async {
    return prefs!.setString('name', name);
  }

  String getName() {
    return prefs!.getString('name') ?? '';
  }

  dynamic setMobile(String mobile) async {
    return prefs!.setString('mobile', mobile);
  }

  String getMobile() {
    return prefs!.getString('mobile') ?? '';
  }

  dynamic setDesignation(String designation) async {
    return prefs!.setString('designation', designation);
  }

  String getDesignation() {
    return prefs!.getString('designation') ?? '';
  }

  dynamic setPhoto(String photo) async {
    return prefs!.setString('photo', photo);
  }

  String getPhoto() {
    return prefs!.getString('photo') ?? '';
  }



  clearPreference(){
    prefs!.clear();
  }

}
