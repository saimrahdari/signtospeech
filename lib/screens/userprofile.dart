import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:signtospeech/models/authentication_service.dart';
import 'package:signtospeech/models/firestorage_service.dart';

import 'message.dart';
import 'more.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedIndex = 0;

  var currentUser = FirebaseAuth.instance.currentUser;
  Map? data;
  var temp;
  
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _contactNoController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _cnicController = new TextEditingController();
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');  

  Future<Widget> _getImage(BuildContext context, String imageName) async{
    late Image image;

    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return image;
  }

  void _getData() async{
    temp = await collectionReference.doc(currentUser!.uid).get();

    setState(() {
      _nameController.text = temp['name'].toString();
      _emailController.text = temp['email_address'].toString();
      _contactNoController.text = temp['contact_number'].toString();
      _cnicController.text = temp['city'].toString();
    });
  }

 @override
  void initState(){

    _getData();
    super.initState();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
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
                              color: Colors.white,
                              onPressed: () {
                                context.read<AuthenticationService>().signOut();
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
                      SizedBox(width: 30),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text('User Profile',
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
                  height: 40,
                ),
                Center(child: 
                FutureBuilder(
                  future: _getImage(context, ("profiles/" + currentUser!.uid.toString() + ".png")),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      return Container(
                        width: 100,
                        height: 100,
                        child: snapshot.data as Widget,
                      );
                    }
                    else if(snapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        width: 100,
                        height: 100,
                        child: Container(),
                      );
                    } else 
                    return Container();
                  }
                ),
                
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text('Personal Details',
                        style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'SFProDisplay',
                                color: Theme.of(context).bottomAppBarTheme.color,))),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Name',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 17,
                color: Theme.of(context).textTheme.headline2!.color,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text('Email Address',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 17,
color: Theme.of(context).textTheme.headline2!.color,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text('Contact Number',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 17,
                        color: Theme.of(context).textTheme.headline2!.color,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _contactNoController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text('City',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 17,
                        color: Theme.of(context).textTheme.headline2!.color,
                      )),
                ),
                Padding( 
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _cnicController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                      color: Theme.of(context).dividerColor,),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                  Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
