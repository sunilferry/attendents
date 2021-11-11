import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:updgme_app/helper/pref_manager.dart';
import 'package:updgme_app/models/salary_model.dart';
import 'package:updgme_app/networks/api_calls.dart';
import 'package:updgme_app/screens/no_records.dart';

class Salary extends StatefulWidget {
  @override
  _SalaryState createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
  bool isLoading=true;
  SalaryListResponse? salaryListResponse;
  @override
  void initState() {
    super.initState();
    getSalary();
  }
  getSalary()async{
    salaryListResponse=await ApiCalls.apiCalls!.getSalary(PrefManager.prefManager!.getToken());
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
                    'Welcome to pay summary details',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
            isLoading?Expanded(child: Center(child: CircularProgressIndicator()),):salaryListResponse!=null?Flexible(
              child: Card(
                margin: EdgeInsets.all(8),
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: ScrollPhysics(),
                    itemCount: salaryListResponse!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  salaryListResponse!.data[index].paymentDate,
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff212b62)),
                                ),
                                Text(
                                  '\u20b9${salaryListResponse!.data[index].amountPaidtoOutsource}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff0f184c),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'EPF Amount',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  'EPF Challan Number',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\u20b9${salaryListResponse!.data[index].epfAmount}',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff212b62)),
                                ),
                                Text(
                                  '${salaryListResponse!.data[index].epftrrnNo}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff0f184c),
                                      ),
                                )
                              ],
                            ),
                            SizedBox(height: 8,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ESIC Amount',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  'ESIC Challan Number',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\u20b9${salaryListResponse!.data[index].esiAmount}',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff212b62)),
                                ),
                                Text(
                                  '${salaryListResponse!.data[index].esiChallanNo}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff0f184c),
                                     ),
                                )
                              ],
                            ),
                            SizedBox(height: 8,),
                            Divider(height: 1,color: Colors.grey,)
                          ],
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
