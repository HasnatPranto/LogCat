import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:student_rec/db_helper.dart';
import 'package:student_rec/student_details.dart';
import 'package:student_rec/student_model.dart';

class StudentList extends StatefulWidget{
  int selectedClass;
  StudentList({Key key, this.selectedClass}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _studentListState(selectedClass);
  }
}
class _studentListState extends State<StudentList>{
  TextEditingController filter = new TextEditingController();
  String searhText="";
  int sc;
  List<Student> fullList=List<Student>();
  List<Student> filteredList=List<Student>();
  bool loaded=false;

  DBHelper dbHelper;

  _studentListState(int scl){
    this.sc=scl;
  }

  Future buildList() async{
    var stu= await dbHelper.getStudents(sc);
    setState(() {
      filteredList = stu;
    });
  }
  @override
  void initState() {
    super.initState();
    dbHelper=DBHelper();
  }
  @override void dispose() {
    filter.dispose();
    super.dispose();
  }
  void searchByName(String value) async{

    var stu= await dbHelper.getStudents(sc);

    setState(() {
      fullList = stu;
    });
    setState(() {
      filteredList=fullList.where((test)=>test.name.toLowerCase().contains(value.toLowerCase())).toList();});
  }
  @override  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xff505bda),Color(0xff315b96)])
              ),
            ),
            title: Text('Class $sc',
              style: TextStyle(
                  color: Color(0xffffffff),fontSize: 30,fontFamily: 'Josefin')),
          ),
        ),
        body: new Container(

          child: Column(
            children: <Widget>[
            SizedBox(height: 10,),
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new TextField(
                onChanged: (value){
                  searchByName(value);
                },
                controller: filter,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                 hintText: 'Search a Student',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
                child:
                FutureBuilder<List<Student>>(
                    future: dbHelper.getStudents(sc),
                    builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot){
                      if(snapshot.hasData && snapshot.data.toString()!= '[]'){
                        if (!loaded) {
                          fullList = snapshot.data;
                          filteredList = fullList;
                          loaded = true;
                        }
                        return ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (BuildContext context, int index){
                              return Card(
                                  color: Colors.lightGreenAccent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.transparent, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 1.0,
                                child: Ink(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.topLeft,
                                        colors: [Color(0xff7f78d2),Color(0xffd2d0fe)]
                                    )
                                ),
                                  child: InkWell (child:  ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                    child: Icon(Icons.person_outline),
                                  ),
                                  title: Text(filteredList[index].name,style: TextStyle(fontSize: 20,color: Color(0xff342b38)),),
                                  subtitle: Text('Contact No. '+filteredList[index].pp,style: TextStyle(fontSize: 15,color: Color(0xff342b38)),),
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => StudentDetail(student: filteredList[index]))).then((value){
                                          buildList();
                                    });
                                  },
                                    trailing:  Icon(Icons.keyboard_arrow_right, color: Colors.white),
                                ),
                                )));
                            });
                      }
                      else {
                        return Container(
                          padding: EdgeInsets.all(20),
                      child:
                      Text('No Records Yet..'),
                        );
                      }
                    }
                )
              )
          ],
        )));
  }
}
