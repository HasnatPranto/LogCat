import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_rec/db_helper.dart';
import 'package:student_rec/student_list.dart';
import 'package:student_rec/student_model.dart';

class EditPage extends StatefulWidget {
  Student student;
  EditPage({Key key,this.student}) : super(key:key);
  @override
  _editPageState createState() => _editPageState(student);
}

class _editPageState extends State<EditPage> {
  Student student;
  DBHelper dbHelper;

  _editPageState(Student student){
    this.student=student;
    dbHelper=DBHelper();
  }
  final _formKey = GlobalKey<FormState>();
  int prevId;
  String _studentName,_studentCls,_studentRoll,_studentGrp,_studentGN,_studentPN,_studentSection;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title: Text('Edit', style: TextStyle(fontSize: 25,fontFamily: 'Arista')),
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
        body:
        SingleChildScrollView(
            child:
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [Color(0xffcce9ff),Colors.white]
                )
              ),
                padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Builder(
                    builder: (context) => Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Change Student Info',style: TextStyle(fontFamily:'Sofia',fontWeight:FontWeight.bold,color: Colors.black87,fontSize: 30)),
                              SizedBox(height: 20,),
                              TextFormField(
                                initialValue: student.name,
                                //style: TextStyle(color: Colors.deepPurpleAccent),
                                decoration:
                                InputDecoration(
                                  labelText: 'Student Name',
                                  border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide()
                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter the name';
                                  }
                                },
                                onSaved: (value) =>
                                    setState(() => _studentName = value),
                              ),

                              SizedBox(height: 20),

                              TextFormField(
                                initialValue: student.cls,
                                //style: TextStyle(color: Colors.deepPurpleAccent),
                                decoration:
                                InputDecoration(
                                  labelText: 'Class',
                                  hintText: 'e.g 6',
                                  border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide()
                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter the class';
                                  }
                                },
                                onSaved: (value) =>
                                    setState(() => _studentCls = value),
                              ),
                              SizedBox(height: 20),

                              TextFormField(
                                initialValue: student.roll,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly],
                               // style: TextStyle(color: Colors.deepPurpleAccent),
                                decoration:
                                InputDecoration(
                                  labelText: 'Roll',
                                  border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide()
                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter the roll';
                                  }
                                },
                                onSaved: (value) =>
                                    setState(() => _studentRoll = value),
                              ),
                              SizedBox(height: 20),

                              TextFormField(
                                initialValue: student.sec,
                                  //style: TextStyle(color: Colors.deepPurpleAccent),
                                  decoration:
                                  InputDecoration(
                                    labelText: 'Section',
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0),
                                        borderSide: new BorderSide()
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    if(value.isEmpty){
                                      setState(() {
                                        _studentSection='N/A';
                                      });
                                    }
                                    else
                                      setState(() => _studentSection = value);
                                  }
                              ),
                              SizedBox(height: 20),

                              TextFormField(
                                initialValue: student.grp,
                                 // style: TextStyle(color: Colors.deepPurpleAccent),
                                  decoration:
                                  InputDecoration(
                                    labelText: 'Group', hintText: 'Only for Class IX or X',
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0),
                                        borderSide: new BorderSide()
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),

                                  onSaved: (value){
                                    if(value.isEmpty) setState(() => _studentGrp='N/A');
                                    else
                                      setState(() => _studentGrp = value);
                                  }
                              ),
                              SizedBox(height: 20),

                              TextFormField(
                                initialValue: student.pp,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly],
                                  //style: TextStyle(color: Colors.deepPurpleAccent),
                                  decoration:
                                  InputDecoration(
                                    labelText: 'Personal Cell Number',
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0),
                                        borderSide: new BorderSide()
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  onSaved: (value){
                                    if(value.isEmpty) setState(() => _studentPN='N/A');
                                    else
                                      setState(() => _studentPN = value);}
                              ),
                              SizedBox(height: 20),

                              TextFormField(
                                initialValue: student.gp,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly],
                                  decoration:
                                  InputDecoration(
                                    labelText: 'Guardian Cell Number',
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0),
                                        borderSide: new BorderSide()
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),

                                  onSaved: (value) {
                                    if(value.isEmpty) setState(() => _studentGN='N/A');
                                    else
                                      setState(() => _studentGN = value);}
                              ),
                              SizedBox(height:268),
                            ]))))),
        floatingActionButton: new Builder(builder: (BuildContext context) {
          return new FloatingActionButton.extended(
              onPressed: () async {
                prevId=student.id;
                final form = _formKey.currentState;
                if (form.validate()) {
                  form.save();
                   dbHelper.update(Student(student.id, _studentName,_studentRoll,_studentCls,_studentSection,_studentGrp,_studentGN,_studentPN));
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Info Changed..')));
                }
              },label: Text('Save'),icon: Icon(Icons.done),backgroundColor: Colors.green[800],splashColor: Colors.green[900]);
        }));
  }
}