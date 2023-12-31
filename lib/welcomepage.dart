import 'package:flash_chat/registerpage.dart';
import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// Notes : Async means that some function is asynchronous and you might need to wait a bit to get its result. Await literally means - wait here until this function is finished and you will get its return value. Future is a type that 'comes from the future' and returns value from your asynchronous function.

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  // SingleTickerProvider is used when we need a ticker for a single animation, whereas for multiple animations, we use TickerProvider
  late AnimationController controller; // creating a controller
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this);
    // vsync is an @required property and is used to select the ticker for this particular animation

    Animation animation;
    animation = ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
    // Tween uses a begin and end value and makes the animation move within that range

    controller.forward(); // this is for starting the AnimationController
    // controller.reverse() makes the animation move in the reverse direction

    controller.addListener(() {
      setState(() { // setState is used to perform a rebuild of the app after each time the ticker's value is changed
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // controller.value is something that denotes the value of the ticker after each rebuild (goes from 0 to 1)
      // so, its used for properties where the parameter's range is a double from 0 to 1.
      // By changing its upperbound value we can change it's max range as well
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero( // Hero widget is use to provide animations to the flutter app
                  // if an element is present on both pages, we can use the hero widget to provide a smooth transition in the form of an animation
                  tag: 'logo', // both the hero widgets on the two pages must have the same tag to interact with each other - it kinda acts like an identifier
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit( // this widget is used by importing the animated text kit package
                  animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                    textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black
                    ),
                      speed: const Duration(milliseconds: 120),// changing the typing speed
                    ),
                  ],
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
