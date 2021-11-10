import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:updgme_app/helper/pref_manager.dart';
import 'package:updgme_app/models/login_model.dart';
import 'package:updgme_app/networks/api_calls.dart';
import 'package:updgme_app/screens/home.dart';
class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  final userIdCtrl=TextEditingController();
  final passwordCtrl=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiCalls.getInstance();
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
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(

            
            children: [
              SizedBox(height: 100,),
              Image.asset('assets/logo.png',height: 100,),
              SizedBox(height: 24,),
              Text('जन शक्ति',style: TextStyle(color: Colors.blue,fontSize: 28),),
              SizedBox(height: 30,),
              Text('Directorate General of Medical\nEducation and Training U. P.',textAlign: TextAlign.center,),
              SizedBox(height: 32,),
              TextFormField(
                controller: userIdCtrl,
                decoration: InputDecoration(
                  hintText:'User Id',
                  labelText: 'User Id',
                  border: OutlineInputBorder(

                  )
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: passwordCtrl,
                decoration: InputDecoration(
                    hintText:'Password',
                    labelText: 'Password',
                    border: OutlineInputBorder(

                    )
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: (){},child: Text('Forgot Password?'),),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async{
                    String userid=userIdCtrl.text.toString();
                    String password=passwordCtrl.text.toString();
                    final requestParam={'email':userid,
                    'password':generateMd5(password)};
                    LoginResponse? response=await ApiCalls.apiCalls!.login(requestParam);
                    if(response==null){
                      toast('Login Failed');
                    }else if(response.status){
                      PrefManager.prefManager!.setId(response.data.response.id);
                      PrefManager.prefManager!.setToken(response.data.response.jwtToken);
                      PrefManager.prefManager!.setName(response.data.response.userName);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                    }else{
                      toast('Login Failed');
                    }
                    print(response);
                  },

                  child: Text('Login'),
                ),
              ),
              SizedBox(height: 16,),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0) //                 <--- border radius here
                    ),
                  ),
                  padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                  margin: EdgeInsets.only(top: 16),
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_searching,color: Colors.blue,),
                      SizedBox(width: 16,),
                      Text('Get Current Location',style: TextStyle(color: Colors.blue),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Icon(Icons.call,color: Colors.blue,),
                  SizedBox(width: 16,),
                  Text('Technical Support:'),
                  Text('+91-7607370200',style: TextStyle(color: Colors.blue),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
