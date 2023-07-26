import 'package:flutter/material.dart';
// creating these constant values are useful as they can used directly in any other part of the code

const kSendButtonTextStyle = TextStyle( // A specific style of text
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration( // I/p field decoration
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration( // specific box decoration that can be used anywhere
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);