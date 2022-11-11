import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Models/admin_data.dart';
import '../Bottom Bar/Verify_doctor.dart';
import '../Bottom Bar/Doctor_List.dart';
import '../Bottom Bar/Patient_List.dart';
import '../Login/Login_page.dart';

class HomePage extends StatefulWidget {
  var index;
  HomePage({required this.index});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  UserModel loggedInUser = UserModel();
  static User? user = FirebaseAuth.instance.currentUser;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List _widgetOptions = <Widget>[
    Confirm_Doctor(),
    Patient_List(),
    Doctor_List(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedInUser = UserModel();
    FirebaseFirestore.instance
        .collection("admin")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        print("loggedInUser === "+ loggedInUser.toString());
      });
    });
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Admin",style: TextStyle(),)),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => login_page()));
              },
              icon: SvgPicture.asset('assets/images/power.svg', color: Colors.white,))
        ],
      ),
      body:loggedInUser.uid == null?Center(child: Container(child: Text("You Are Not Admin.",),)): _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/patient.png"),
            ),
            label: 'Patient',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/doctor.png"),
            ),
            label: 'Doctor',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    ));
  }
}
