import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:signtospeech/screens/feedbacks.dart';
import 'package:signtospeech/screens/questionnaires.dart';
import 'package:signtospeech/screens/userprofile.dart';

import 'message.dart';

class MorePage extends StatefulWidget {
  MorePage({ Key? key }) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int _selectedIndex = 0;

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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
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
                          child: Text('More',
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Image.asset('assets/images/comingsoonIcon.png'),
                        Container(
                          width: 160,
                          child: Text('Following Features are coming soon !', style: TextStyle(
                            color: Theme.of(context).textTheme.headline4!.color,
                            fontFamily: 'SFProDisplay',
                            fontSize: 20,
                          )),
                        ),
                      ],),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionnairesPage()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 155,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Image.asset('assets/images/questionnairesIcon.png'),
                          Text('Questionnaires', style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 18, fontFamily: 'SFProDisplay'))
                        ],),
                                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedbacksPage()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 155,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Image.asset('assets/images/meetingsIcon.png'),
                          Text('Feedbacks', style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 18, fontFamily: 'SFProDisplay'))
                        ],),
                                        ),
                      ),
                    ],),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}