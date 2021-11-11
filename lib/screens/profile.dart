import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:updgme_app/helper/pref_manager.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameCtrl=TextEditingController();
  final emailCtrl=TextEditingController();
  final mobileCtrl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameCtrl.text=PrefManager.prefManager!.getName();
    emailCtrl.text=PrefManager.prefManager!.getEmail();
    mobileCtrl.text=PrefManager.prefManager!.getMobile();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16),
                width: double.infinity,
                height: MediaQuery.of(context).size.height/5,
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrefManager.prefManager!.getPhoto().isEmpty?Image.asset('assets/logo.png',height: 100,):ClipOval(child:
                    Image.network(PrefManager.prefManager!.getPhoto(),height: 100,width: 100,fit: BoxFit.cover,)),
                    SizedBox(height: 16,),
                    Text('Welcome to your profile',style: TextStyle(fontSize: 16,color: Colors.white),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: nameCtrl,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:'Name',
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_outline)
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextField(
                      controller: emailCtrl,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:'Email',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.person_outline)
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextField(
                      controller: mobileCtrl,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:'Mobile',
                          labelText: 'Mobile',
                          prefixIcon: Icon(Icons.person_outline)
                      ),
                    ),

                    SizedBox(height: 16,),
                    item('Change Password', Icon(Icons.password,color: Colors.white,)),
                    SizedBox(height: 16,),
                    item('Help & Support', Icon(Icons.help_outline,color: Colors.white,)),
                    SizedBox(height: 16,),
                    item('Share App', Icon(Icons.share,color: Colors.white,)),
                    SizedBox(height: 16,),
                    item('Rate App', Icon(Icons.star_rate_outlined,color: Colors.white,)),
                    SizedBox(height: 16,),
                    item('Logout', Icon(Icons.logout,color: Colors.white,))
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
  Widget item(String name,Icon icon){
    return  Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: icon,
        ),
        SizedBox(width: 16,),
        Text(name),
      ],
    );
  }
}
