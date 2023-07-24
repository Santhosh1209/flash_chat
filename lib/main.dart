import 'package:flutter/material.dart';
import 'welcomepage.dart';
import 'registerpage.dart';
void main() {
  runApp(const FlashChat());
}
 class FlashChat extends StatelessWidget {
   const FlashChat({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       theme: ThemeData.dark().copyWith(
         textTheme: TextTheme(
           bodyLarge: TextStyle( color: Colors.black54
           )
         )
       ),
       home: RegistrationScreen(),
     );
   }
 }
