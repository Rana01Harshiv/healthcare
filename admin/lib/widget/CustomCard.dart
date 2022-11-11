
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Screens/Detail/Pending_Doctor_detail.dart';
import '../constants.dart';


class CustomCard extends StatelessWidget {
  var id;
  var p_name;
  var last_name;
  var profileImage;
  var specialist;

  CustomCard(this.id, this.p_name, this.last_name, this.profileImage, this.specialist);

  // CustomCard({});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
                print("ub="+profileImage);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(uid: id,)));
      },
      child: Column(
        children: [

          ListTile(
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
            title: Text(p_name + " "+ last_name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: Row(
              children: [
                Text(
                  specialist +' specialist',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),

              ],
            ),
        //    trailing: Text("08:00"),
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