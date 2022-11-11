
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Screens/Detail/Doctor_Detail.dart';
import '../Screens/Detail/Pending_Doctor_detail.dart';
import '../constants.dart';


class CustomCard2 extends StatelessWidget {
  var id;
  var d_name;
  var profileImage;

  CustomCard2(this.id, this.d_name, this.profileImage);

  // CustomCard({});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
                print("ub="+profileImage);
                print("ub -"+id);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Doctor_detail(uid: id,)));
      },
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 31.00,
                backgroundColor: kPrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child:profileImage == false?
                  CircleAvatar(
                    radius: 30.00,
                    backgroundImage: AssetImage('assets/images/account.png'),
                  ): CircleAvatar(
                    radius: 30.00,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                ),
              ),
              title: Text(d_name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}