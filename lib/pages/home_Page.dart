import 'package:first_01/widget/quick_Action_Widget.dart';
import 'package:first_01/widget/recent_activities_widgets.dart';
import 'package:first_01/widget/static_cards.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {



  const HomePage({super.key,});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: const [
            Text(
          "Good Morning!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2),

        Text(
          "How are you feeling today?",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
      ),

     actions: [
        IconButton(
          icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.black12), // Bell icon
          onPressed: () {
            // Handle bell icon tap
          },
        ),
        IconButton(
          icon: const Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.black12,), // Profile icon
          onPressed: () {
            // Handle profile icon tap
          },
        ),
      ],
      backgroundColor: Colors.white,

    ),
    body: SingleChildScrollView(


      child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children:[

        Container(
               width: 400,
               height: 120,
               margin: EdgeInsets.fromLTRB(40,40,40,40),
               padding: EdgeInsets.fromLTRB(19,12,0,0),
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3B82F6), // from-blue-500
                    Color(0xFF8B5CF6), // to-purple-600
                  ],
                ),
              ),
             child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,

                     children: [
                       Text("Today's Summary",
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w600,
                         color: Colors.white
                       ),),

                       SizedBox(height: 20), // space between texts

                       Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                              Text("Overall Score",
                              style:TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,)
                              ),
                              Text("87/100",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),)
                            ]),
                            SizedBox(width: 80),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                              Text("Streak",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12
                                ),
                              ),
                              Text("12 days",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                            ])
                          ],
                        ),
                     ]
                   ),),

        Row(
               mainAxisAlignment: MainAxisAlignment. center,
               children: [

                 StaticCards(
                   cardIcon: Icons.favorite_border,
                   text:"Heart Rate",
                   statusNumber: "70",
                   measureIcon:" bpm",
                   cardIconColor: Colors.red,
                   progressBarColor: Colors.green,
                   showProgress: false,),

                 SizedBox(width:11),


                 StaticCards(
                   cardIcon: Icons.monitor_heart,
                   text:"Steps", statusNumber: "8,489",
                   measureIcon:"",
                   cardIconColor: Colors.green,
                   progressBarColor: Colors.green,
                   showProgress: true,),
                ]
        ),

        SizedBox(height: 11,),

        Row(
                     mainAxisAlignment: MainAxisAlignment. center,
                     children: [

                       StaticCards(
                           cardIcon: Icons.water_drop,
                           text: "Water", statusNumber: "6",
                           measureIcon: " /8 glasses",
                           cardIconColor: Colors.blue,
                           progressBarColor: Colors.blue,
                          showProgress: true
                       ),

                       SizedBox(width: 11,),

                       StaticCards(
                           cardIcon: Icons.water_drop,
                           text: "Sleep", statusNumber: "7.5",
                           measureIcon: " hours",
                           cardIconColor: Colors.deepPurpleAccent,
                           progressBarColor: Colors.deepPurpleAccent,
                         showProgress: true
                       ),

                      ]

             ),

        Container(
                margin: EdgeInsets.fromLTRB(40,20,0,16), // You can also use EdgeInsets.only(...)
                child: Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

        Row(
               mainAxisAlignment: MainAxisAlignment. center,

               children: [
                 QuickActionWidget(
                   text: "Log Meal",
                   color: Colors.deepOrange, icon: Icons.add,
                 ),

                 SizedBox(width: 11,),

                 QuickActionWidget(
                   text:"Start Workout",
                   color: Colors.green,
                   icon: Icons.monitor_heart,)
               ]

        ),

        SizedBox(height: 11,),

        Row(
               mainAxisAlignment: MainAxisAlignment. center,
               children: [
                 
                 QuickActionWidget(
                     text: "Set Goals",
                     color: Colors.blue,
                     icon: Icons.sports_score),

                 SizedBox(width: 11,),

                 QuickActionWidget(
                     text: "Start Workout",
                     color: Colors.purple,
                     icon: Icons.calendar_month_rounded,),
              ]

                     ),

        Container(
                margin: EdgeInsets.fromLTRB(40,20,0,12), // You can also use EdgeInsets.only(...)
                child: Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

        SizedBox(height: 19,),

        RecentActivitiesWidgets(
          containerColor: Color(0xAEE1E169),
          containerIcon: Icons.search,
          activityName: "Logged breakfast",
          time: "10.30 AM"),

        SizedBox(height: 19,),

        RecentActivitiesWidgets(
          containerColor: Color(0xC8AD6ADF),
          containerIcon: Icons.child_care,
          activityName: "15 min meditation",
          time: "9:15 AM"),

        SizedBox(height: 19,),

        RecentActivitiesWidgets(
          containerColor: Color(0xC04AB7E4),
          containerIcon: Icons.water_drop_sharp,
          activityName: "15 min meditation",
          time: "9:15 AM"),

      ]
        ),
    ),

  );
  }
}


