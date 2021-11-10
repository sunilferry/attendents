import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_face_api_beta/face_api.dart' as Regula;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:updgme_app/helper/constants.dart';

import 'home.dart';

class PunchAttendance extends StatefulWidget {
  @override
  _PunchAttendanceState createState() => _PunchAttendanceState();
}

enum SingingCharacter { punchIn, out ,non}

class _PunchAttendanceState extends State<PunchAttendance> {
  SingingCharacter? _character = SingingCharacter.non;
  //Regula.Image? image1;
  Regula.Image? image2;
  var img1 = Image.asset('assets/images/portrait.png');
  var img2 = Image.asset('assets/images/portrait.png');
  String _similarity = "nil";
  Uint8List? bytes;
  int count=0;
  String machMessage='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getLocation();


  }

  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);

  }

  getLocation()async{
    Position position=await _determinePosition();
    print(position.longitude);
   /* String? base64=await networkImageToBase64("http://janshakti.upsdc.gov.in/Upload/Employee/1_(26)_jpg-2021-Nov-09-16-31-14-547.jpg");
    print(base64);

    image1 = new Regula.Image();
    image1!.bitmap =base64!;
    image1!.imageType = Regula.ImageType.IMAGE_TYPE_LIVE;*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Punch Attendance'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(8),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Lottie.asset('assets/walk.json', height: 70),
                              Text('Lucknow')
                            ],
                          ),
                          Column(
                            children: [
                              Text('25.4 m'),
                              Image.asset(
                                'assets/arrow.png',
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/office.png',
                                height: 70,
                              ),
                              Text('Lucknow')
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'You are 5.6 Meters away from office',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Punch Attendance',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      SizedBox(height: 32,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(children: [
                            Radio<SingingCharacter>(
                              value: SingingCharacter.punchIn,
                              groupValue: _character,
                              onChanged: (SingingCharacter? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                            Text('Punch In')
                          ],),
                          Row(
                            children: [
                              Radio<SingingCharacter>(
                                value: SingingCharacter.out,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                              Text('Punch Out')
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 32,),
                      Text(
                        'Please capture selfie to mark your attendance',
                      ),
                      SizedBox(height: 32,),
                      GestureDetector(
                        onTap: (){
                          Regula.FaceSDK.presentFaceCaptureActivity()
                              .then((response) {
                                String base=Regula.FaceCaptureResponse.fromJson(
                                    json.decode(response!))!
                                    .image!
                                    .bitmap!
                                    .replaceAll("\n", "");
                            print("Sunil" + base );

                            bytes = base64Decode(base);
                            machMessage='';
                            setImage(false, base64Decode(base), Regula.ImageType.IMAGE_TYPE_LIVE);

                           /* if(count==0){
                              count=1;
                              setImage(

                                  true,
                                  base64Decode(Regula.FaceCaptureResponse.fromJson(
                                      json.decode(response))!
                                      .image!
                                      .bitmap!
                                      .replaceAll("\n", "")),
                                  Regula.ImageType.IMAGE_TYPE_LIVE);
                            }else{
                              count=0;
                              setImage(
                                  false,
                                  base64Decode(Regula.FaceCaptureResponse.fromJson(
                                      json.decode(response))!
                                      .image!
                                      .bitmap!
                                      .replaceAll("\n", "")),
                                  Regula.ImageType.IMAGE_TYPE_LIVE);
                            }*/

                          });
                        },
                        child: bytes != null
                            ? Container(
                            height: 100, width: 100, child: Image.memory(bytes!))
                            : Image.asset('assets/selfie.png',height: 100,),
                      ),

                      SizedBox(height: 32,),
                      Container(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: (){

                            matchFaces();
                          }, child: Text('SUBMIT')))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setImage(bool first, List<int> imageFile, int type) {
    print("bollean $first");
    if (first) {

      image1 = new Regula.Image();
      image1!.bitmap = base64Encode(imageFile);
      image1!.imageType = type;

    } else {
      image2 = new Regula.Image();
      image2!.bitmap = base64Encode(imageFile);
      image2!.imageType = type;

    }

    setState(() {

    });


  }

  matchFaces() {
    if (image1!.bitmap == null ||
        image1!.bitmap == "" ||
        image2!.bitmap == null ||
        image2!.bitmap == "") return;
    setState(() => _similarity = "Processing...");
    var request = new Regula.MatchFacesRequest();
    request.images = [image1, image2];
    Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
      var matchedFaces = response!.matchedFaces;
      _similarity = matchedFaces.length > 0
          ? ((matchedFaces[0]!.similarity! * 100).toStringAsFixed(2) )
          : "error";
      if(_similarity=='error'){
        machMessage='Failed';
      }else{
        double match=double.parse(_similarity);
        if(match>70){
          machMessage='Matched';
        }else{
          machMessage='Failed';
        }
      }

      toast(machMessage);
    });
  }

  toast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }


  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

}
