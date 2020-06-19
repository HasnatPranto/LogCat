import 'package:flutter/material.dart';

class Me extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xffcef1f2),Color(0xff4282b2)],
                ),
              ),
            ),
            title: Text("Contact Me", textAlign: TextAlign.left, style: TextStyle(color:Color(0xff042a4d),fontSize: 35,fontFamily: 'Lobster'),),
            elevation: .1,
        ),
        body:  Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [Color(0xff8fc6ef),Colors.white]
            )
          ),
          padding: EdgeInsets.all(25),
              //alignment: Alignment.center,
            child:  Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  ),],
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                height: 170,
                child: Column(
                  children: <Widget>[
                    Text('You Know How To Reach Me, Keep In Touch..',
                      style: TextStyle(color: Colors.blueGrey,fontWeight:FontWeight.w800,fontSize: 20,fontFamily: 'Sofia')),
                    SizedBox(height: 18,),
                    RaisedButton(
                          color: Colors.white,
                           child: Text('Ok',style: TextStyle(fontSize: 25,color: Color(0xff042a4d)),),
                           onPressed: (){
                             Navigator.of(context).pop();
                           },
                        )
                  ],
                )
              ),
            )

          //Text('You Know How To Reach Me, Keep In Touch..',style: TextStyle(color: Colors.blueGrey,fontWeight:FontWeight.w700,fontSize: 20,fontFamily: 'Sofia'),)
          ),
    );
  }
}