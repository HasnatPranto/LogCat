import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_rec/db_helper.dart';
import 'package:student_rec/student_model.dart';

import 'class_page.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  List<int> bytes=[];

  Widget cava= CircleAvatar(backgroundColor:Colors.blueGrey[100], radius:45,child:Icon(Icons.account_circle,size: 60,color: Colors.black12,));
  final _formKey = GlobalKey<FormState>();
  String _studentName,_studentCls,_studentRoll,_studentGrp,_studentGN,_studentPN,_studentSection,imgStr="",year,imgPath="";
  DBHelper dbHelper;
   bool imgExist=false;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  Widget sheetRow(BuildContext context, String text, int opt){
    return InkWell(
        onTap: () {
          switch(opt){
            case 1: Navigator.pop(context); chooseImage();
                    break;
            case 2: Navigator.pop(context);
                    setState(() {
                      cava= CircleAvatar(backgroundColor:Colors.white30, radius:45,child:Icon(Icons.account_circle));
                      imgExist=false;
                      imgStr="";
                    });
            }
        },
        child: Row(
          children: <Widget>[
            Padding( padding: const EdgeInsets.only(left:30,top:18,bottom: 18),
              child: Text(text, style: TextStyle(fontSize: 17)),
            ),
          ],
        ),
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
  bool classCheck(String value){
    int i= int.parse(value);
    bool b;
    (i>10 && i<6)? b= false : b= true;
    return b;
  }
  Future chooseImage() async{

     var image= await ImagePicker.pickImage(source: ImageSource.gallery);
     //bytes = image.readAsBytesSync();

     setState(() {
       imgPath = image.path;
      //imgStr=base64.encode(bytes);
      imgExist = true;
      cava = CircleAvatar(
          radius: 45,
          backgroundImage: new FileImage(image)); // backgroundImage: Image.memory(_bytesImage).image
     });
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(
          title: Text('New Student Entry', style: TextStyle(fontSize: 25,fontFamily: 'Arista')),
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
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
               colors: [Color(0xffeef2f3),Color(0xff8e9eab)]
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
                          Text('Fill Out Student Info',style: TextStyle(fontFamily:'Sofia',fontWeight:FontWeight.bold,color: Colors.black87,fontSize: 30)),
                          SizedBox(height: 20,),
                          Center(
                            child: InkWell(
                                child: cava,
                                onTap: (){
                                  if(!imgExist)
                                  chooseImage();
                                  else
                                    bottomMenu(context);
                                },
                            )
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            style: TextStyle(color: Colors.deepPurpleAccent),
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
                            style: TextStyle(color: Colors.deepPurpleAccent),
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
                            style: TextStyle(color: Colors.deepPurpleAccent),
                            decoration:
                            InputDecoration(
                              labelText: 'Year',
                              hintText: 'e.g 2010',
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly],
                            style: TextStyle(color: Colors.deepPurpleAccent),
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
                            style: TextStyle(color: Colors.deepPurpleAccent),
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
                            style: TextStyle(color: Colors.deepPurpleAccent),
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly],
                            style: TextStyle(color: Colors.deepPurpleAccent),
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly],
                            style: TextStyle(color: Colors.deepPurpleAccent),
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
            final form = _formKey.currentState;
            if (form.validate()) {
              form.save();
              dbHelper.add(Student(null, _studentName,imgPath,_studentRoll,_studentCls,year,_studentSection,_studentGrp,_studentGN,_studentPN));
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('One New Entry Added..')));
              await Future.delayed(Duration(milliseconds: 2000), () {});
              Navigator.pop(context);
            }
          },label: Text('Confirm'),icon: Icon(Icons.done),backgroundColor: Colors.pink,splashColor: Colors.yellow);
        }));
  }
}