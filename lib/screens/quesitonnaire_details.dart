import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'message.dart';
import 'more.dart';
import 'userprofile.dart';

class QuestionnaireDetailsPage extends StatefulWidget {
  String docId;

  QuestionnaireDetailsPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<QuestionnaireDetailsPage> createState() => _QuestionnaireDetailsPageState();
}

class _QuestionnaireDetailsPageState extends State<QuestionnaireDetailsPage> {
  int _selectedIndex = 0;

  bool? _applyUni, _issueUni;
  TextEditingController _nameController = new TextEditingController();
  
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');  
  
  Future<void> _updateData(String name, bool applyUni, bool issueUni) async {
      collectionReference.doc(currentUser!.uid).collection('questionnaire').doc(widget.docId).update(
        {'name' : name,
         'applyUni': applyUni,
         'issueUni': issueUni,
         'submitted' : true}
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Questionnaire Submitted Successfully"),
      ));
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Questionnaire Not Submitted Successfully"),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(floatingActionButton: Visibility(
        visible: !keyboardIsOpened,
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: null,
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 251, 123, 162),
                            Color.fromARGB(255, 252, 224, 67),
                          ],
                        ),
                ),
                child: Icon(
                  Icons.playlist_add_check,
                  size: 35,
                  color: Color.fromARGB(255, 54, 54, 54)
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        height: 65,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          child: new BottomNavigationBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  if(index == 0){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessagePage()),
                    );
                  }
                  else if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfilePage()),
                    );
                  } else if (index == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MorePage()),
                    );
                  }
                });
              },
              selectedItemColor: Color.fromARGB(255, 251, 123, 162),
              unselectedItemColor: Color.fromARGB(255, 251, 123, 162),
              currentIndex: _selectedIndex,
              items: [
                BottomNavigationBarItem(
                    icon: new Icon(
                      Icons.message_rounded,
                      size: 30,
                    ),
                    title: new Text(
                      'Message',
                      style: TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.call,
                    size: 30,
                  ),
                  title: new Text(
                    'Call',
                    style: TextStyle(
                      fontFamily: 'SegoeUI',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.transparent,
                    ),
                    title: Text('')),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_rounded,
                      size: 30,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 30,
                    ),
                    title: Text(
                      'More',
                      style: TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ]),
        ),
      ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Ink(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: IconButton(
                              color: Theme.of(context).textTheme.headline4!.color,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                ),
                              )),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text('Questionnaires',
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'SFProDisplay',
                                color: Theme.of(context).bottomAppBarTheme.color,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text('Feedback Form',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SFProDisplay',
                            color: Theme.of(context).bottomAppBarTheme.color,
                            fontWeight: FontWeight.w500)),
                  ),
                  Text(
                      'Please answer the given questions about your admission progress. Your responses will be recorded.',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'SFProDisplay',
                          color: Theme.of(context).textTheme.subtitle2!.color,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  Text(
                    'Name',
                    style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 16, color: Theme.of(context).textTheme.subtitle2!.color),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14, fontFamily: 'SFProDisplay',color: Theme.of(context).textTheme.headline3!.color),
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    'Have you applied in any university?',
                    style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 16, color: Theme.of(context).textTheme.subtitle2!.color,),
                  ),
                  SizedBox(
                    height: 10, 
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _applyUni = true;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: _applyUni == true ? Color.fromARGB(255, 251, 123, 162) : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: _applyUni != true? Border.all(
                              color: Color.fromARGB(255, 251, 123, 162),
                              style: BorderStyle.solid,
                              width: 1.5): null,
                        ),
                        child: Center(child: Text('Yes', style: TextStyle(color: _applyUni == true ? Colors.white : Colors.black, fontFamily: 'SFProDisplay', fontSize: 15),)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _applyUni = false;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: _applyUni == false ? Color.fromARGB(255, 251, 123, 162) : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: _applyUni != false ? Border.all(
                              color: Color.fromARGB(255, 251, 123, 162),
                              style: BorderStyle.solid,
                              width: 1.5): null,
                        ),
                        child: Center(child: Text('No', style: TextStyle(color: _applyUni == false ? Colors.white : Colors.black, fontFamily: 'SFProDisplay', fontSize: 15),)),
                      ),
                    ),
                  ],),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    'Are you facing any problem in the admission process?',
                    style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 16, color: Theme.of(context).textTheme.subtitle2!.color),
                  ),
                  SizedBox(
                    height: 10, 
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _issueUni = true;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: _issueUni == true ? Color.fromARGB(255, 251, 123, 162) : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: _issueUni != true ? Border.all(
                              color: Color.fromARGB(255, 251, 123, 162),
                              style: BorderStyle.solid,
                              width: 1.5): null,
                        ),
                        child: Center(child: Text('Yes', style: TextStyle(color: _issueUni == true ? Colors.white : Colors.black, fontFamily: 'SFProDisplay', fontSize: 15),)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _issueUni = false;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: _issueUni == false ? Color.fromARGB(255, 251, 123, 162) : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: _issueUni != false ? Border.all(
                              color: Color.fromARGB(255, 251, 123, 162),
                              style: BorderStyle.solid,
                              width: 1.5) : null,
                        ),
                        child: Center(child: Text('No', style: TextStyle(color: _issueUni == false ? Colors.white : Colors.black, fontFamily: 'SFProDisplay', fontSize: 15),)),
                      ),
                    ),
                  ],),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  GestureDetector(
                    onTap: () {
                      _updateData(_nameController.text, _applyUni!, _issueUni!);
                    },
                    child: Center(
                      child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.width * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(child: Text('Submit', style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,))),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
