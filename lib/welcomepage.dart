import 'package:flash_chat/registerpage.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png'),
                  height: 60.0,
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                  ),
                ),
              ],
            ),
            SizedBox( // SizedBox widget is used to force a specific width and/or height for its child.
              // that is, its used to properly fit some widgets into the layout
              height: 48.0,
            ),
            Padding( // used for spacing
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material( // used for design
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    // used to go to the login screen
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) // here, the route can be also be defined separately instead of using 'BuildContext context'
                    // For this purpose, we can use navigator.pushNamed (context,route) where the route can either be something like a static property or a hard coded text
                    {
                      return LoginScreen();
                    },
                    ),);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    // used to go to the registration screen
                    // similarly, if you want add a button that enables you to go back, use navigator.pop(context)
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
                    {
                      return RegistrationScreen();
                    },
                    ),);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
