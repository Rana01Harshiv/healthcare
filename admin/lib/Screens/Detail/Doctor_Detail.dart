import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../componets/loadingindicator.dart';
import '../../constants.dart';
import '../Bottom Bar/Doctor_List.dart';
import '../Home/HomePage.dart';
import 'Patient_detail.dart';


class Doctor_detail extends StatefulWidget {
  var uid;


  Doctor_detail({
    required this.uid,
  });

  @override
  _Doctor_detailState createState() => _Doctor_detailState();
}

class _Doctor_detailState extends State<Doctor_detail> {
  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************
  var rating;

  List<int> rating_no = [];
  var sum = 0;

  var myDocuments =0 ;
  bool isLoading = true;
  var today_app2 = 0;
  var docid;
  var name;
  var email;
  var address;
  var experience;
  var specialist;
  var last_name;
  var description;
  var phone;
  var profileImage;
  var patient_count =0;
  var rating_count =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<void>.delayed(const Duration(seconds: 2), () {
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
                    future: FirebaseFirestore.instance.collection('doctor').where('uid', isEqualTo: widget.uid )
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
                   /*   if (snapshot.hasError) {
                        return  Center(child: CircularProgressIndicator());
                      }*/
                      print("snapshot: " + snapshot.hasData.toString());
                    /*  snapshot.data?.docs.asMap().forEach((index, doc) {
                        //  sum = sum + int.parse(doc["rating"]);
                        if (today_app2 > index) {
                          rating_no.add(int.parse(doc["rating_s"]));
                        }
                      });
                      sum = 0;
                      rating_no.asMap().forEach((index, element) {
                        if (index < today_app2) {
                          sum = sum + element;
                          print("SUM = " + element.toString());
                        }
                      });
                      print("=========================================");

                      rating = sum / int.parse(today_app2.toString());*/

                      print("snapshot: " + snapshot.hasData.toString());
                      snapshot.data?.docs.asMap().forEach((index, doc) {
                        docid = doc.id;
                        name = doc['name'];
                        address = doc['address'];
                        experience = doc['experience'];
                        specialist = doc['specialist'];
                        address = doc['address'];
                        address = doc['address'];
                        description = doc['description'];
                        email =doc['email'];
                        phone =doc['phone'];
                        profileImage =doc['profileImage'];
                        rating =double.parse(doc['rating']);

                      });


                      return SizedBox();

                      /*Text(rating.toString());*/
                    },
                  )
              ),
              SizedBox(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('pending').where('did', isEqualTo: widget.uid )
                        .get()
                        .then((myDocuments) {
                      setState(() {
                        patient_count = myDocuments.docs.length;
                      });
                      print(
                          "${"lenght = " + myDocuments.docs.length.toString()}");
                      return myDocuments;
                    }),

                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return  SizedBox();
                      }
                   /*   if (snapshot.hasError) {
                        return  Center(child: CircularProgressIndicator());
                      }*/



                      return SizedBox();

                      /*Text(rating.toString());*/
                    },
                  )
              ),
              SizedBox(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('rating')
                        .get()
                        .then((myDocuments) {
                      setState(() {
                        rating_count = myDocuments.docs.length;
                      });
                      print(
                          "${"lenght = " + myDocuments.docs.length.toString()}");
                      return myDocuments;
                    }),

                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return  SizedBox();
                      }
                   /*   if (snapshot.hasError) {
                        return  Center(child: CircularProgressIndicator());
                      }*/



                      return SizedBox();

                      /*Text(rating.toString());*/
                    },
                  )
              ),

            ],
          ),
        ),
      )
          : SingleChildScrollView(

        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // sleep(Duration(seconds:  1)),

            _titleSection(size),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr.' + name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add_location,
                        size: 14,
                        color: kPrimaryhinttext,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          address,
                          style: TextStyle(
                            color: kPrimaryhinttext,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.fade,
                          ),

                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xffFFF9EA),
                      border: Border.all(
                          color: Color(0xffFFEDBE), width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      specialist + ' Specialist',
                      style: TextStyle(
                        color: Color(0xffFFBF11),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    description,
                    // 'Dr.' +name+
                    //     ' a Renal Physician who has comprehensive expertise in the fields of Renal Medicine and Internal Medicine. While Dr Ho specializes in dialysis and critical care nephrology, years of extensive training have also equipped him with skills to effectively handle a wide range of other kidney diseases, including kidney impairment, inflammation, infection and transplantation.',
                     style: TextStyle(
                      color: kPrimaryhinttext,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 91,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DetailCell(title: patient_count.toString(), subTitle: 'Patients'),
                        DetailCell(
                            title: experience + '+',
                            subTitle: 'Exp. Years'),
                        DetailCell(title: rating_count.toString(), subTitle: 'Rated'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Apart from kidney-related conditions, Dr Ho also offers care and consultation in various medical conditions that are related to kidney disease, such as hypertension, diabetes and vascular diseases.',
                    style: TextStyle(
                      color: kPrimaryhinttext,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
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
                      ),
                      Container(
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

                            dialog();



                         //   Navigator.pop(context);
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
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
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
          //overflow: Overflow.visible,
          alignment: Alignment.topCenter,
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
                                FirebaseFirestore.instance.collection('doctor').doc(widget.uid).delete();
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage(index: 2)) );
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
        onPressed: () =>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage(index: 2))),
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
            right:size.width/3.5 ,
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
                      child:profileImage == false?CircleAvatar(
                        radius: 80.00,
                        backgroundImage: AssetImage('assets/images/account.png'),
                      ): CircleAvatar(
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
          Positioned(
            right: 32,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xffFFBB23),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    rating.toStringAsFixed(1).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),

          /* FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('doctor').doc(widget.uid).collection('rating').where('rating', isGreaterThan: 0).get(),
                  /*.then((allFeedbackDocs) => {
                allFeedbackDocs.documents.forEach((feedbackDoc) {
                  var feedData = feedbackDoc.data;
                })
              }),*/
              // .orderBy('Created', descending: true | false)
                /*.then((myDocuments) {
                setState(() {
                  today_app2 = myDocuments.docs.length;

                });
                print("${myDocuments.docs.length}");
                return myDocuments;
              }),*/
              builder: (context, snapshot) {

                  setState(() {
                  //  sum =  snapshot.data!['rating'];
                  });
                if (snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(
                    child: ListView.builder(
                        itemCount: today_app2.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Text('${myDocuments['rating'].title}');
                        }
                    )
                );
              }),*/
        ],
      ),
    );
  }





  Widget buildStar(BuildContext context, int index) {
    var icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: Colors.amber,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: Colors.amber,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Colors.amber,
      );
    }
    return icon;
  }
}

class StarDisplay extends StatelessWidget {
  final double value;

  const StarDisplay({this.value = 0}) : assert(value != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: 25,
        );
      }),
    );
  }
}
