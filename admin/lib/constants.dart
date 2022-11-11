import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF1471A1);
const kPrimarydark = Color(0xFF8AD4F2);
const kPrimaryLightColor = Color(0xFFd7e0fb);
const kprimaryLightBlue=Color(0xFFD5F3FE);
const kPrimaryLightdark = Color(0xFFe3dbed);
const kPrimaryhinttext = Color(0xFFF929BB0);
// const  var size = MediaQuery.of(context).size;


const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);


const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);