import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:student_rec/Edit_page.dart';
import 'package:student_rec/db_helper.dart';
import 'package:student_rec/student_model.dart';

class StudentDetail extends StatefulWidget{
  Student student;
  StudentDetail({Key key,this.student}) : super(key:key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailState(student);
  }
}
class fullSize extends StatelessWidget{
  String imageString;
  fullSize({Key key,this.imageString}) : super(key:key);
  var _fi;

  @override
  Widget build(BuildContext context) {

    _fi= Image.memory(base64Decode(imageString));

    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
          color: Colors.black,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: _fi.image,
                      fit: BoxFit.contain
                  )
              ),
            ),
            onTap: (){
              Navigator.pop(context);
            },
          )
      )
    );
  }
}
class DetailState extends State<StudentDetail> {
  Student student;
  DBHelper dbHelper;
  var _image;
  DetailState(Student student){
    this.student=student;
    dbHelper=DBHelper();

  }
  @override
  void initState() {
    super.initState();
    if(student.image!=""){
      setState(() {
        _image= Image.memory(base64Decode(student.image));
      });
    }
    else{
      _image = Image.asset('assets/images/unidentified.png');
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
        title: Text('Student Details', style: TextStyle(fontSize: 25,fontFamily: 'Arista')),
    flexibleSpace: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [Color(0xff5f5f87),Color(0xff323247)])
    ),
    )
    // backgroundColor: Color.fromRGBO(13,1,54, 1.0)
    ),
      body: Container(
        color: Color(0xffa6dcef),
        padding: EdgeInsets.only(top: 25),
        child:  Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
            ),
         child: Container(
           padding: EdgeInsets.fromLTRB(20, 20, 5, 5),
           decoration: BoxDecoration(
               boxShadow: [
                 BoxShadow(
                   color: Colors.blueGrey.withOpacity(0.3),
                   spreadRadius: 7,
                   blurRadius: 5, // changes position of shadow
                 ),
               ],
               gradient: LinearGradient(begin: Alignment.bottomRight,end: Alignment.topLeft, colors: [Color(0xff8fc6ef),Colors.white],stops: [.2,.8]),
               borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
           ),
           child: ListView(
             children: <Widget>[
                   Stack(
                     alignment: Alignment.topRight,
                     children: <Widget>[
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                           children: <Widget>[
                             SizedBox(height: 10) ,
                         Text('Name',style: TextStyle(color:Color(0xff363062),fontSize: 22,)),
                         SizedBox(height: 6,),
                         Text(student.name,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6,),
                         Text('Class',style: TextStyle(color:Color(0xff363062),fontSize: 22,),),
                         SizedBox(height: 6,),
                         Text(student.cls,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6,),
                         Text('Year',style: TextStyle(color:Color(0xff363062),fontSize: 22,)),
                         SizedBox(height: 6),
                         Text(student.year,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6),
                         Text('Section',style: TextStyle(color:Color(0xff363062),fontSize: 22,),),
                         SizedBox(height: 6,),
                         Text(student.sec,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6,),
                         Text('Group',style: TextStyle(color:Color(0xff363062),fontSize: 22,)),
                         SizedBox(height: 6,),
                         Text(student.grp,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6,),
                         Text('Roll',style: TextStyle(color:Color(0xff363062),fontSize: 22,)),
                         SizedBox(height: 6,),
                         Text(student.roll,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6,),
                         Text('Contact No.(Student)',style: TextStyle(color:Color(0xff363062),fontSize: 22)),
                         SizedBox(height: 6,),
                         Text(student.pp,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6,),
                         Text('Contact No.(Guardian)',style: TextStyle(color:Color(0xff363062),fontSize: 22)),
                         SizedBox(height: 6,),
                         Text(student.gp,style: TextStyle(fontSize: 27,fontFamily:'Josefin')),
                         SizedBox(height: 6,)
                       ]),
                       Positioned(
                           right: 15,
                           child: GestureDetector(
                             child: Container(
                               height: 115.0,
                               width: 105.0,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(topLeft:Radius.circular(5),bottomRight:Radius.circular(5),bottomLeft:Radius.circular(5),topRight:Radius.circular(20)),
                                 border: Border.all(width:2,color: Color(0xff4b6cb7)),
                                 image: DecorationImage(
                                   image: _image.image,
                                   fit: BoxFit.fill,
                                 ),
                                 // shape: BoxShape.circle,
                               ),
                             ),
                             onTap: () {
                               if(student.image==""){
                                 Flushbar(
                                   message:  "No image to show!",
                                   duration:  Duration(seconds: 2),
                                 )..show(context);
                               }
                               else {
                                 Navigator.push(
                                     context, MaterialPageRoute(
                                     builder: (context) =>
                                         fullSize(imageString: student.image)));
                                }
                               },
                           )
                       ),
                     ],
                   ),
             ],
           ),
         )
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.white,
        animatedIcon: AnimatedIcons.list_view,
        animatedIconTheme: IconThemeData(size: 23,color: Colors.blue[800]),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child: Icon(Icons.delete,color: Colors.red[800]),
              backgroundColor: Colors.white,
              onTap: () async {
                alert(context);
                /* do anything **/},
              label: 'Delete Record',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Colors.blueAccent),
          SpeedDialChild(
              child: Icon(Icons.edit,color: Colors.amber[800]),
              backgroundColor: Colors.white,
              onTap: () async { await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EditPage(student: student)));
                Navigator.of(context).pop();
              },
              label: 'Edit Record',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Colors.blueAccent),
        ],
      ),
    );
  }
  Widget alert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
          return AlertDialog(
            shape: (
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)))
            ),
            elevation: 10,
            title: Text('Are You Sure?'),
            content: Text('Delete this Student Record?'),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () async {
                  await dbHelper.delete(student.id);
                  Navigator.of(context).pop();Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Return"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
      },
    );
  }
}