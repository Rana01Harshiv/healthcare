import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../componets/loadingindicator.dart';
import '../../constants.dart';
import '../Bottom Bar/Verify_doctor.dart';
import '../Bottom Bar/Patient_List.dart';
import '../Home/HomePage.dart';


class PatientPage extends StatefulWidget {
  var uid;


  PatientPage({
    required this.uid,
  });

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************
  double rating = 3.2;

  List<int> rating_no = [];
  var sum = 0;

  var myDocuments =0 ;
  bool isLoading = true;
  var today_app2 = 0;
  var docid;
  var name;
  var email;
  var address;
  var age;
  var dob;
  var gender;
  var status;
  var phone;
  var profileImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<void>.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: isLoading == true
          ? Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Loading(),
              SizedBox(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('patient').where('uid', isEqualTo: widget.uid )
                    /*.doc(widget.uid)
                            .collection('/rating')*/
                        .get()
                        .then((myDocuments) {
                      setState(() {
                        today_app2 = myDocuments.docs.length;
                      });
                      print(
                          "${"lenght = " + myDocuments.docs.length.toString()}");
                      return myDocuments;
                    }),

                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return  Center(child: Text(" "));
                      }
                      print("snapshot: " + snapshot.hasData.toString());
                      snapshot.data?.docs.asMap().forEach((index, doc) {
                        docid = doc.id;
                        name = doc['name'] +" "+ doc['last name'];
                        address = doc['address'];
                        age = doc['age'];
                        dob = doc['dob'];
                        gender = doc['gender'];
                        email =doc['email'];
                        phone =doc['phone'];
                        status =doc['status'];
                        profileImage =doc['profileImage'];

                      });

                      return SizedBox();

                      /*Text(rating.toString());*/
                    },
                  )
              )
            ],
          ),
        ),
      )
          : Stack(

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // sleep(Duration(seconds:  1)),

                  _titleSection(size),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.add_location,
                              size: 14,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(address,
                              style: TextStyle(
                                color: kPrimaryhinttext,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(children: [
                            Icon(
                              Icons.email,
                              size: 18,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(email,
                              style: TextStyle(
                                color: kPrimaryhinttext,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                            Icon(
                              Icons.call,
                              size: 18,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(phone,
                              style: TextStyle(
                                color: kPrimaryhinttext,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child:  Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFBB23),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                bottom: 10,
                right: 10,
                child:    Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      //  FirebaseFirestore.instance.collection('patient').doc(widget.uid).delete();
                      dialog();
                      // Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Delete Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
    );
  }

  /// **********************************************
  /// WIDGETS
  /// **********************************************

  void dialog() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
        child: Stack(
          clipBehavior: Clip.none, alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      'are you sure you want delete profile?',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //child: ),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),

                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(8), // <-- Radius
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 30,
                          ),
                          Container(

                            child: ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('patient').doc(widget.uid).delete();
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage(index: 1)) );
                                //   Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal:19 ),
                                child: Text(
                                  'Ok',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -50,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 50,
                  child: Image.asset('assets/images/logo.jpg'),
                  // Icon(Icons.assistant_photo, color: Colors.white, size: 50,),
                )),
          ],
        ),
      ));

  /// App Bar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 25),
        onPressed: () =>  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage(index: 1)) ),
      ),
    );
  }

  //Title Section
  Container _titleSection(Size size) {
    return Container(
      height: 250,
      color: kPrimaryColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 207,
              height: 178,
              child: Image(
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/images/bg_shape.png'),
              ),
            ),
          ),
          Positioned(
            right: size.width/3.5,
            bottom: -3,
            child: Container(
              height: 250,

              child: AspectRatio(
                aspectRatio: 196 / 285,
                child: Hero(
                    tag: name,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 80,

                        backgroundImage: NetworkImage(profileImage),

                      ),
                    )/*Image(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(profileImage),
                  ),*/
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 15,
              color: Colors.white,
            ),
          ),



        ],
      ),
    );
  }

}

class DetailCell extends StatelessWidget
{
  final String title;
  final String subTitle;

  const DetailCell({

    required this.title,
    required this.subTitle,
  }) ;

  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: Color(0xff696969),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}