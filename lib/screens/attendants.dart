import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:updgme_app/helper/pref_manager.dart';
import 'package:updgme_app/models/attendant_list_model.dart';
import 'package:updgme_app/models/salary_model.dart';
import 'package:updgme_app/networks/api_calls.dart';
import 'package:updgme_app/screens/no_records.dart';

class Attendants extends StatefulWidget {
  @override
  _AttendantsState createState() => _AttendantsState();
}

class _AttendantsState extends State<Attendants> {
  bool isLoading=true;
  AttendantListResponse? attendantListResponse;
  @override
  void initState() {
    super.initState();
    getSalary();
  }
  getSalary()async{
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    final requestParam = {'fromDate': formattedDate, 'toDate': formattedDate};
    attendantListResponse=await ApiCalls.apiCalls!.getAttendants(requestParam,PrefManager.prefManager!.getToken());
    isLoading=false;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 9,
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hey, ${PrefManager.prefManager!.getName()}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Please select START and END Date to see your Attendance List with Date and Time',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  )
                ],
              ),
            ),
            isLoading?Expanded(child: Center(child: CircularProgressIndicator()),):attendantListResponse!=null?Flexible(
              child: Container(
                margin: EdgeInsets.all(8),
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: ScrollPhysics(),
                    itemCount: attendantListResponse!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Date: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    attendantListResponse!
                                        .data[index].attendanceDate,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Punch Type: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    attendantListResponse!
                                        .data[index].attendanceType,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ):Expanded(child: NoRecord())
          ],
        ),
      ),
    );
  }
}
