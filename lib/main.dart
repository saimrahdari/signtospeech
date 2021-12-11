import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signtospeech/screens/login.dart';
import 'package:signtospeech/screens/userprofile.dart';

import 'models/authentication_service.dart';  

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: 
          MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarColor : Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Color.fromARGB(255, 251, 123, 162),
          ),
          primaryColor: Color.fromARGB(255, 251, 123, 162),
          dividerColor: Color.fromARGB(255, 251, 123, 162),
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Color.fromARGB(255, 251, 123, 162),
            ),
            headline2: TextStyle(
              color: Colors.black,
            ),
            headline3: TextStyle(
              color: Color.fromARGB(255, 62, 62, 62),
            ),
            headline4: TextStyle(
              color: Colors.white,
            ),
            headline5: TextStyle(
              color: Color.fromARGB(255, 251, 123, 162),
            ),
              headline6: TextStyle(
              color: Colors.white,
            ),
            subtitle1: TextStyle(
              color: Color.fromARGB(255, 245, 245, 245),
            ),
            subtitle2: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        home: SplashScreen()
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => AuthenticationWrapper())));

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 330,
            ),
            Text('Sign to Speech',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'SFProDisplay',
              color: Color.fromARGB(255, 251, 123, 162),
              )
            ),
            SizedBox(
              height: 300,
            ),
            Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SFProDisplay',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}   

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
  
    if (firebaseUser != null) {
      return UserProfilePage();
    }
    return LoginPage();
  }
}

