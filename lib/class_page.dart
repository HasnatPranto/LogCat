import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:student_rec/form_page.dart';
import 'package:student_rec/student_list.dart';
import 'me.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      //colors: [Color(0xffede5c7),Color(0xffcc8a53), Color(0xffcb7633)]
                      colors: [Color(0xffbf953f),Color(0xfffcf6ba),Color(0xffb38728)]
                    //colors: [Color(0xff3a7bd5),Color(0xff3B4371)],
                  ),
              ),
            ),
            title: Text(" LogCat", textAlign: TextAlign.center, style: TextStyle(color:Color(0xff360033),fontSize: 35,fontFamily: 'Lobster'),),
        elevation: 5,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help_outline,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Me()));
              // do something
            },
          )
        ]),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
              colors: [Color(0xffd7dde8),Color(0xffFFEFBA)]
             //colors: [Color(0xffbf953f),Color(0xfffcf6ba),Color(0xffb38728),Color(0xfffbf5b7),Color(0xffaa771c)]
          )
        ),
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: .95,
          padding: EdgeInsets.all(7.0),
          children: <Widget>[
            makeDashboardItem("Class VI", Icons.filter_6,230,0,51),
            makeDashboardItem("Class VII", Icons.filter_7,0,141,183),
            makeDashboardItem("Class VIII", Icons.filter_8,48,40,51),
            makeDashboardItem("Class IX", Icons.filter_9,0,83,63),
            makeDashboardItem("Class X", Icons.spa,251,120,19),
            makeDashboardItem("Former\nStudents", Icons.check_circle,217,1,102),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormPage()));// Add your onPressed code here!
        },

        child: Icon(Icons.person_add),
        backgroundColor: Color(0xff52c234),
        splashColor: Colors.green[900],
      ),
    );
  }

  Widget makeDashboardItem(String title, IconData icon, int r, int g, int b) {

    return Card(
        color: Colors.transparent,
        shape:
        RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10.0,
        margin: new EdgeInsets.all(5.0),
          child: Ink(
            decoration: BoxDecoration(
             /* gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Color.fromRGBO(r,g,b,1.0),Color.fromRGBO(r,g,b,.7)]
              ),*/
             color: Colors.white30,
              //color: Color.fromRGBO(r,g,b,1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            height: 300,
            child: new InkWell(
              onTap: () {
                if(title=="Class VI")
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => StudentList(selectedClass: 6)));
                else if(title=="Class VII")
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => StudentList(selectedClass: 7)));
                else if(title=="Class VIII")
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => StudentList(selectedClass: 8)));
                else if(title=="Class IX")
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => StudentList(selectedClass: 9)));
                else if(title=="Class X")
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => StudentList(selectedClass: 10)));
                else if(title=="Former\nStudents")
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => StudentList(selectedClass: 0)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  SizedBox(height: 50.0),
                /*Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(5.0, 10.0))
                      ]),*/
                  Center(
                      child: Ink(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [Color.fromRGBO(r,g,b,1.0),Color.fromRGBO(r, g, b, .25)]
                          ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8.0,
                                  offset: Offset(5.0, 8.0))
                            ]),
                        child:  CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            icon,
                            size: 30.0,
                            color:Colors.white,
                          ) ,
                        ),
                      ),
                  ),
                  SizedBox(height: 15.0),
                  new Center(
                    child: new Text(title,
                        style:
                        new TextStyle(fontFamily:'Lobster',fontSize: 20.0, color: Color(0xff1F1C18))),
                  )
                ],
              ),
            ),
          )
        );
  }
}