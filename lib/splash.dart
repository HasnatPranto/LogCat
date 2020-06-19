import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:student_rec/class_page.dart';
import 'package:student_rec/me.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
            (status) {
          if (status) {
            _navigateToHome();
          }
        }
    );
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 4000), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => Dashboard()
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xffc4e86b),Color(0xff00a399)])
          ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 250,
            ),
            Center(
              child: Shimmer.fromColors(
                period: Duration(milliseconds: 1500),
                baseColor: Colors.white,
                highlightColor: Colors.black26,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 5),
                  child:
                  Text(
                    "LogCat",
                    style: TextStyle(
                        fontSize: 60.0,
                        fontFamily: 'Arista'
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Keeping Student Records Made Easy!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'ubuntu',
                  color: Colors.white,
                ),
              ),
            ),
           /* SizedBox(
              height: 290,
            ),
            Text("Powered By Hz™",style: TextStyle(color:Colors.amber,fontSize: 17))*/
           Expanded(
             child: Align(
             alignment: Alignment.bottomCenter,
             child: SizedBox(
               height: 30,
               width: double.infinity,
               child: Text("Powered By Hz™",textAlign: TextAlign.center,style: TextStyle(color:Colors.amber,fontSize: 15)),
             )
           ))],
        )
      ),
    );
  }


}