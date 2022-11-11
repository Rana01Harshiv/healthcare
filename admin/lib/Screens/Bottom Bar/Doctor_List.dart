import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../componets/loadingindicator.dart';
import '../../widget/CustomCard.dart';
import '../../widget/CustomCard2.dart';


class Doctor_List extends StatefulWidget {
  const Doctor_List({Key? key}) : super(key: key);

  @override
  State<Doctor_List> createState() => _Doctor_ListState();
}

class _Doctor_ListState extends State<Doctor_List> {
  var appointment = FirebaseFirestore.instance;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    super.initState();


    setState(() {
      sleep(Duration(seconds: 1));
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    var firebase = appointment.collection('doctor').snapshots();
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: firebase,
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text(" ");
                  } else {
                    return isLoading
                        ? Container(
                      margin: EdgeInsets.only(top: size.height * 0.4),
                      child: Center(
                        child: Loading(),
                      ),
                    )
                        : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot doc =
                          snapshot.data!.docs[index];
                          Future.delayed(Duration(seconds: 3));
                          return snapshot.hasError
                              ? Center(child: Text("patient Not Available"))
                              : CustomCard2(doc['uid'],doc['name'],doc['profileImage'].toString());
                        },
                      ),
                    );
                  }
                }),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
              color: Colors.white,
              height: 50,
              width: size.width * 1,
              child: Container(
                  margin: EdgeInsets.only(top: 17,left: 15),
                  child: Text("Verified Doctor",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))),
        ),
      ],
    );
  }
}
