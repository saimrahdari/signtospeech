import 'package:flutter/material.dart';
import 'package:signtospeech/screens/userprofile.dart';

import 'more.dart';

class MessagePage extends StatefulWidget {
  

  MessagePage({ Key? key }) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    
    return Scaffold(
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
      
    );
  }
}