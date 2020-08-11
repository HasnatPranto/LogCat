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
                      colors: [Color(0xff3a7bd5),Color(0xff3B4371)],
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
              colors: [Color(0xff4389A2),Color(0xff5C258D)]
            // colors: [Color(0xfffdbb2d),Color(0xffb21f1f),Color(0xff1a2a6c)]
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
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Color.fromRGBO(r, g, b, 1),
                      child: Icon(
                        icon,
                        size: 30.0,
                        color:Colors.white,
                      ) ,
                    )
                  ),
                  SizedBox(height: 15.0),
                  new Center(
                    child: new Text(title,
                        style:
                        new TextStyle(fontSize: 17.0, color: Colors.white)),
                  )
                ],
              ),
            ),
          )
        );
  }
}