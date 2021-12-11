
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:signtospeech/models/authentication_service.dart';
import 'package:signtospeech/screens/userprofile.dart';
import 'message.dart';
import 'more.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus)
            currentFocus.unfocus();
        },
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 251, 123, 162),
          bottomNavigationBar: SingleChildScrollView(
          child: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.headline6!.color,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email Address',
                      style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 15, color: Theme.of(context).textTheme.headline2!.color),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, fontFamily: 'SFProDisplay',color: Theme.of(context).textTheme.headline3!.color),
                      controller: _emailController,
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 15, color: Theme.of(context).textTheme.headline2!.color),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, fontFamily: 'SFProDisplay',color: Theme.of(context).textTheme.headline3!.color),
                      controller: _passwordController,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: GestureDetector(
                        onTap: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                               style: Theme.of(context).textTheme.headline2!.copyWith(
                                fontSize: 13,
                                fontFamily: 'SFProDisplay',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.69,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                              onPressed: () {
                                context.read<AuthenticationService>().signIn(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                              },
                              child: Text('Login', style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: 16,
                                fontFamily: 'SFProDisplay',
                              ),),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                              onPressed: null,
                              child: Icon(Icons.fingerprint, color: Theme.of(context).textTheme.headline4!.color),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Center(child: Text('or continue with', style: Theme.of(context).textTheme.headline2!.copyWith(
                                fontSize: 16,
                                fontFamily: 'SFProDisplay',
                              ),)),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0))),
                              side: MaterialStateProperty.all(BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5,
                                  style: BorderStyle.solid))),
                          icon: Icon(FontAwesomeIcons.google, color: Theme.of(context).primaryColor, size: 20),
                          label: Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFProDisplay',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: null,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0))),
                              side: MaterialStateProperty.all(BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5,
                                  style: BorderStyle.solid))),
                          icon: Icon(Icons.facebook, color: Theme.of(context).primaryColor),
                          label: Text(
                            'Continue with Facebook',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFProDisplay',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ), 
            body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'SFProDisplay'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text(
                    'Login to continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'SFProDisplay'),
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