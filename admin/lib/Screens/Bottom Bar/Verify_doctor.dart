import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../componets/loadingindicator.dart';
import '../../widget/CustomCard.dart';

class Confirm_Doctor extends StatefulWidget {
  const Confirm_Doctor({Key? key}) : super(key: key);

  @override
  State<Confirm_Doctor> createState() => _Confirm_DoctorState();
}

class _Confirm_DoctorState extends State<Confirm_Doctor> {
  var appointment = FirebaseFirestore.instance;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    super.initState();

    Future<void>.delayed(const Duration(seconds:1), () {
      if (mounted) {
        // Check that the widget is still mounted
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var firebase = appointment.collection('pending_doctor').snapshots();
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: firebase,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    ? Center(
                                        child: Text("Doctor Not Available"))
                                    : CustomCard(
                                        doc['uid'],
                                        doc['name'],
                                        doc['last name'],
                                        doc['profileImage'].toString(),
                                        doc['specialist']);
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
                  child: Text("Pending Verification",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))),
        ),
      ],
    );
  }
}
