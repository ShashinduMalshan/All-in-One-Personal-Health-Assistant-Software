import 'package:flutter/material.dart';

class RecentActivitiesWidgets extends StatelessWidget {
  final Color containerColor;
  final IconData containerIcon;
  final String activityName;
  final String time;

  const RecentActivitiesWidgets({super.key, required this.containerColor, required this.containerIcon, required this.activityName, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 33,
              height: 33,
              margin: EdgeInsets.fromLTRB(40,0,0,0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: containerColor,
              ),
              child:Center(
                  child: Icon(
                  containerIcon,
                  color: Colors.white,
                  size: 20,)),
            ),

            SizedBox(width: 8,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activityName,
                style:TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.black87
                ),),

                Text(
                  time,
                style:TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Colors.black38
                ),),
              ],
            )
          ],
        );
  }
}
