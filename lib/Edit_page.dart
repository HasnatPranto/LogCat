import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_rec/db_helper.dart';
import 'package:student_rec/student_list.dart';
import 'package:student_rec/student_model.dart';

import 'class_page.dart';

class EditPage extends StatefulWidget {
  Student student;
  EditPage({Key key,this.student}) : super(key:key);
  @override
  _editPageState createState() => _editPageState(student);
}

class _editPageState extends State<EditPage> {
  Student student;
  DBHelper dbHelper;
  FileImage img;
  var _image;
  Widget cava;
  List<int> bytes;
  bool imgExist = true;

  _editPageState(Student student){
    this.student = student;
    dbHelper=DBHelper();
  }
  final _formKey = GlobalKey<FormState>();
  int prevId;
  String _studentName,_studentCls,_studentRoll,_studentGrp,_studentGN,_studentPN,_studentSection,year,imgStr;

  @override
  void initState() {
    super.initState();
    imgStr=student.image;
    dbHelper = DBHelper();
    if(student.image!=""){
    cava =  CircleAvatar(
       radius: 50,
       backgroundColor: Colors.deepPurpleAccent,
       child: CircleAvatar(
         radius: 48,
       backgroundImage: FileImage(File(imgStr)))
    );
    }
    else{
      imgExist=false;
      cava =  CircleAvatar(
          backgroundColor:Colors.blueGrey[100],
          radius: 50,
          child: Icon(Icons.account_circle,size: 60,color: Colors.black12));
    }
  }

  Future chooseImage() async{

    var image= await ImagePicker.pickImage(source: ImageSource.gallery);
   // bytes= image.readAsBytesSync();

    setState(() {
      imgStr= image.path;
      imgExist = true;
      cava = CircleAvatar(
          radius: 50,
          backgroundImage: new FileImage(image)); // backgroundImage: Image.memory(_bytesImage).image
    });
  }
  Widget sheetRow(BuildContext context, String text, int opt){
    return InkWell(
      child: Row(
        children: <Widget>[
          Padding( padding: const EdgeInsets.only(left:30,top:18,bottom: 18),
            child: Text(text, style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
      onTap: () {
        switch(opt){
          case 1: Navigator.pop(context); chooseImage();
          break;
          case 2: Navigator.pop(context);
          setState(() {
            cava= CircleAvatar(backgroundColor:Colors.blueGrey[100], radius:50,child:Icon(Icons.account_circle,size: 60,color: Colors.black12));
            imgExist=false;
            imgStr="";
          });
        }
      },
    );
  }

  void  bottomMenu(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          sheetRow(context,'Choose another picture',1),
          sheetRow(context,'Remove picture',2),
        ],
      ),
    );
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
                              Center(
                                  child: InkWell(
                                    child: cava,
                                    onTap: (){
                                      if(!imgExist) chooseImage();
                                      else bottomMenu(context);
                                    },
                                  )
                              ),
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
                                  if ((int.parse(value)>10 || int.parse(value)<6) || value.isEmpty) {
                                    return 'Only valid class range: 6 to 10';
                                  }
                                },
                                onSaved: (value) =>
                                    setState(() => _studentCls = value),
                              ),
                              SizedBox(height: 20),

                              TextFormField(
                                initialValue: student.year,
                                //style: TextStyle(color: Colors.deepPurpleAccent),
                                decoration:
                                InputDecoration(
                                  labelText: 'Year',
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
                                    return 'Please enter the year';
                                  }
                                },
                                onSaved: (value) =>
                                    setState(() => year = value),
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
                   dbHelper.update(Student(student.id, _studentName,imgStr,_studentRoll,_studentCls,year,_studentSection,_studentGrp,_studentGN,_studentPN));
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Info Changed..')));
                  await Future.delayed(Duration(milliseconds: 2000), () {});
                  Navigator.pop(context);
                }
              },label: Text('Save'),icon: Icon(Icons.done),backgroundColor: Colors.green[800],splashColor: Colors.green[900]);
        }));
  }
}