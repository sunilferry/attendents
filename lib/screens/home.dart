import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_face_api_beta/face_api.dart' as Regula;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:updgme_app/helper/constants.dart';
import 'package:updgme_app/helper/pref_manager.dart';
import 'package:updgme_app/models/attendant_list_model.dart';
import 'package:updgme_app/models/profile_model.dart';
import 'package:updgme_app/networks/api_calls.dart';
import 'package:updgme_app/screens/punch_attendance.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    print(PrefManager.prefManager!.getToken());
    getProfile();
  }

  ProfileResponse? profileResponse;
  AttendantListResponse? attendantListResponse;

  getProfile() async {
    profileResponse = await ApiCalls.apiCalls!
        .getProfile(PrefManager.prefManager!.getToken());
    if (profileResponse != null && profileResponse!.status) {
      PrefManager.prefManager!.setPhoto(profileResponse!.data.obj.photoUrl);

      String? base64 =
      await networkImageToBase64(profileResponse!.data.obj.photoUrl);
      print(base64);
      image1 = new Regula.Image();
      image1!.bitmap = base64!;
      image1!.imageType = Regula.ImageType.IMAGE_TYPE_LIVE;
      var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);

      final requestParam = {'fromDate': formattedDate,
        'toDate': formattedDate};
      attendantListResponse = await ApiCalls.apiCalls!.getAttendants(
          requestParam, PrefManager.prefManager!.getToken());
      setState(() {

      });
    }
  }

  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 50, right: 16),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'जन शक्ति',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.qr_code, color: Colors.white,),
                              SizedBox(width: 8,),
                              Text(
                                'SCAN QR',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.more_vert_rounded,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logo.png', height: 80,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Day,', style: TextStyle(
                            color: Colors.yellow, fontSize: 24),),
                        Text(PrefManager.prefManager!.getName(),
                          style: TextStyle(color: Colors.white, fontSize: 18),)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 230,
              ),
              Card(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Punch Attendance', style: TextStyle(
                              fontSize: 18),),
                          Text('Daily punch your attendance', style: TextStyle(
                              color: Colors.blue),),
                          SizedBox(height: 70,),
                          Text('Have a nice day...', style: TextStyle(
                              color: Colors.blue),),

                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(60)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PunchAttendance()));
                          },
                          child: Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                border:
                                Border.all(width: 1, color: Colors.blue),
                                borderRadius: BorderRadius.circular(55)),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Punch\nAttendance',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Card(
                    margin: EdgeInsets.only(left: 16, right: 4, top: 8),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 20,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/profile.png')
                          )
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 4, right: 16, top: 8),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 20,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/profile.png')
                          )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text('Today\'s Attendance', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),)),

              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: attendantListResponse==null?Center(child: Text('No record found!')):ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: attendantListResponse!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Date: ',
                                    style: TextStyle(color: Colors.grey),),
                                  Text(attendantListResponse!.data[index].attendanceDate, style: TextStyle(
                                      color: Colors.black, fontSize: 16),)
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  Text('Punch Type: ',
                                    style: TextStyle(color: Colors.grey),),
                                  Text(attendantListResponse!.data[index].attendanceType, style: TextStyle(
                                      color: Colors.black, fontSize: 16),)
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
