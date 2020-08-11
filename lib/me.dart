import 'package:flutter/cupertino.dart';
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
            title: Text("About Me!", textAlign: TextAlign.left, style: TextStyle(color:Color(0xff042a4d),fontSize: 35,fontFamily: 'Lobster'),),
          automaticallyImplyLeading: false,
          elevation: 1,
        ),
        body:  Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            /*gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [Color(0xff8fc6ef),Colors.white]
            )*/
            color: Colors.blueGrey[800]
          ),
          padding: EdgeInsets.only(top: 4,bottom: 1),
              //alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                  Text('You do know what i do, right? Like collecting, updating or removing your student\'s info, that sort of stuffs, yeah..\n\n'
                      'So, why not store all your students\' record in one place (which is inside me ^_− ), rather than writing them on some paper-pages?!\n\n'
                      'And is there something i\'m missing here that would make me more "cool"? Well then, Keep Calm & Contact My Dev ↓↓',style: TextStyle(fontFamily: 'VT32',fontSize: 22,color: Colors.green[800])),
                  SizedBox(height: 6),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(' bsse1026@iit.du.ac.bd',style: TextStyle(fontFamily: 'VT32',fontSize: 19,color: Color(0xff1922b1))),
                          SizedBox(height: 1),
                          Text(' Hasnatul Jilan',style: TextStyle(fontFamily: 'VT32',fontSize: 17,color: Color(0xff1922b1))),
                          SizedBox(height: 2)
                        ],
                      ),
                    ),
                  )
                 ],
              ),
            )
          //Text('You Know How To Reach Me, Keep In Touch..',style: TextStyle(color: Colors.blueGrey,fontWeight:FontWeight.w700,fontSize: 20,fontFamily: 'Sofia'),)
          ),
    );
  }
}
/*Center(
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
            )*/