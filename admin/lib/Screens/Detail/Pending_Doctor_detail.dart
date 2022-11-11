import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../componets/loadingindicator.dart';
import '../../constants.dart';



class DetailPage extends StatefulWidget {
  var uid;


  DetailPage({
    required this.uid,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
  var experience;
  var specialist;
  var last_name;
  var description;
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
                    future: FirebaseFirestore.instance.collection('pending_doctor').where('uid', isEqualTo: widget.uid )
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
                                  experience = doc['experience'];
                                  specialist = doc['specialist'];
                                  address = doc['address'];
                                  address = doc['address'];
                                  description = doc['description'];
                                  email =doc['email'];
                                  phone =doc['phone'];
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
                    // 'Dr.' +
                    //     name+
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

                        DetailCell(
                            title: experience + '+',
                            subTitle: 'Exp. Years'),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    description,
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
                            FirebaseFirestore firebaseFirestore =
                                FirebaseFirestore.instance;
                            firebaseFirestore
                                .collection('doctor')
                               .doc(widget.uid)
                                .set({
                              'uid': widget.uid,
                              'name': name,
                              'phone': phone,
                              'address': address,
                              'email': email,
                              'experience': experience,
                              'specialist': specialist,
                              'description': description,
                              'profileImage':profileImage,
                              'rating':'0.0'
                            })
                                .then((value) => Fluttertoast.showToast(
                                msg: "Registration Successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kPrimaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0)).then((value) =>FirebaseFirestore.instance.collection('pending_doctor').doc(docid).delete())
                                .then((value) =>Navigator.pop(context))
                                .catchError((e) {
                              print("+++++++++" + e);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Verify",
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

  /// App Bar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 25),
        onPressed: () => Navigator.pop(context),
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



        ],
      ),
    );
  }

}

class DetailCell extends StatelessWidget {
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