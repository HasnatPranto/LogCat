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
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xffb6eb7a),Color(0xff17706e)],
                  ),
              ),
            ),
            title: Text(" LogCat", textAlign: TextAlign.center, style: TextStyle(color:Colors.green[900],fontSize: 35,fontFamily: 'Lobster'),),
        elevation: .1,
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
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(7.0),
          children: <Widget>[
            makeDashboardItem("Class VI", Icons.filter_6,230,0,51),
            makeDashboardItem("Class VII", Icons.filter_7,0,141,183),
            makeDashboardItem("Class VIII", Icons.filter_8,48,40,51),
            makeDashboardItem("Class IX", Icons.filter_9,0,83,63),
            makeDashboardItem("Class X", Icons.spa,251,120,19),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormPage()));
          // Add your onPressed code here!
        },

        child: Icon(Icons.person_add),
        backgroundColor: Colors.green[800],
        splashColor: Colors.green[900],
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon, int r, int g, int b) {
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
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Color.fromRGBO(r,g,b,1.0),Color.fromRGBO(r,g,b,.7)]
              ),
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
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color:Colors.white,
                    ) ,
                  ),
                  SizedBox(height: 20.0),
                  new Center(
                    child: new Text(title,
                        style:
                        new TextStyle(fontSize: 20.0, color: Colors.white)),
                  )
                ],
              ),
            ),
          )
        );
  }
}