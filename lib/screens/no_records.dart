import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class NoRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/no_data.json',height: 100),
            Text('No data found!')
          ],
        ),
      ),
    );
  }
}
