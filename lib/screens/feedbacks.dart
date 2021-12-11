import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'message.dart';
import 'more.dart';
import 'quesitonnaire_details.dart';
import 'userprofile.dart';

class FeedbacksPage extends StatefulWidget {
  FeedbacksPage({Key? key}) : super(key: key);

  @override
  State<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {
  int _selectedIndex = 0;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: Visibility(
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
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
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
                                Navigator.pop(context);
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
                        child: Text('Feedbacks',
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'SFProDisplay',
                                    color: Theme.of(context).bottomAppBarTheme.color,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),


                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),

                Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('You can give feedbacks to your recent translations here.',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w500)),
                    ),
SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text('Kindly leave a feedback so that we can make sure that you can have a great experience while using our app. ',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w500)),
                    ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).collection('feedback').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {  
              return new ListView(
                children: snapshot.data!.docs.map((document) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),  
                    child: Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 245, 245),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${document['title']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'SFProDisplay',
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).textTheme.subtitle2!.color)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          height: 60,
                                          child: Text('${document['description']}',
                                            maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'SFProDisplay',
                                                  fontWeight: FontWeight.w300,
                                                  color: Theme.of(context).textTheme.subtitle2!.color),),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                      GestureDetector(
                                        onTap: () {
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  ) ;
                }).toList()
              );
            }
        }
      ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
