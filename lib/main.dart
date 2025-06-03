import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Scaffold(
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
    body: Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
      Container(
             width: 400,
             height: 120,
             margin: EdgeInsets.fromLTRB(40,40,40,0),
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
             mainAxisAlignment: MainAxisAlignment. start,
             children: [Container(
                       width: 160,
                       height: 130,
                       margin: EdgeInsets.fromLTRB(40,30,0,0),
                       padding: EdgeInsets.fromLTRB(19,12,0,0),
                       decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       boxShadow: [
                       BoxShadow(
                          color: Colors.black.withOpacity(0.03), // Shadow color
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 8,  // How blurry the shadow is
                          offset: Offset(0, 0), // Position of the shadow (x, y)
                        ),
                      ],
                       color: Colors.white,

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                       children: [

                         Container(

                           width: 30,
                           height: 30,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(7),
                             color: Colors.red,
                           ),
                           child:
                           Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 18),
                         ),
                         SizedBox(height: 16,),
                         Text("Heart Rate",
                         style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 12,
                           color: Colors.black54
                         ),),
                         SizedBox(height: 10,),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                           Text("70",
                           style: TextStyle(
                             fontWeight: FontWeight.w900,
                             fontSize: 19,


                           ),),
                           Text(" bpm",style:
                           TextStyle(
                             fontWeight: FontWeight.w300,
                             fontSize: 12,
                             color: Colors.black54

                           ),
                           )
                         ],)
                       ],

                     ),

             ),Container(
                       width: 160,
                       height: 130,
                       margin: EdgeInsets.fromLTRB(10,30,40,0),
                       padding: EdgeInsets.fromLTRB(19,12,0,0),
                       decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       boxShadow: [
                       BoxShadow(
                          color: Colors.black.withOpacity(0.03), // Shadow color
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 8,  // How blurry the shadow is
                          offset: Offset(0, 0), // Position of the shadow (x, y)
                        ),
                      ],
                       color: Colors.white,
                       ),
                               child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                       children: [

                         Container(

                           width: 30,
                           height: 30,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(7),
                             color: Colors.green,
                           ),
                           child:
                           Icon(
                            Icons.monitor_heart,
                            color: Colors.white,
                            size: 18),
                         ),
                         SizedBox(height: 16,),
                         Text("Steps",
                         style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 12,
                           color: Colors.black54
                         ),),
                          SizedBox(height: 9),
                           Text("8,489",
                           style: TextStyle(
                             fontWeight: FontWeight.w900,
                             fontSize: 19,


                           ),),

                           Container(
                                width: 120,
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black12,
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.76, // value between 0.0 and 1.0
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              )


                       ],

                     ),

                      ),]

                   ),

      Row(
                   mainAxisAlignment: MainAxisAlignment. spaceAround,
                   children: [Container(
                             width: 160,
                             height: 130,
                             margin: EdgeInsets.fromLTRB(40,10,0,0),
                             padding: EdgeInsets.fromLTRB(19,12,0,0),
                             decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             boxShadow: [
                             BoxShadow(
                                color: Colors.black.withOpacity(0.03), // Shadow color
                                spreadRadius: 1, // How much the shadow spreads
                                blurRadius: 8,  // How blurry the shadow is
                                offset: Offset(0, 0), // Position of the shadow (x, y)
                              ),
                            ],
                             color: Colors.white,
                               ),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                               children: [

                                 Container(

                                   width: 30,
                                   height: 30,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(7),
                                     color: Colors.blue,
                                   ),
                                   child:
                                   Icon(
                                    Icons.water_drop,
                                    color: Colors.white,
                                    size: 18),
                                 ),
                                 SizedBox(height: 16,),
                                 Text("Water",
                                 style: TextStyle(
                                   fontWeight: FontWeight.w500,
                                   fontSize: 12,
                                   color: Colors.black54
                                 ),),
                                  SizedBox(height: 9),
                                   Row(
                                     children:[
                                       Text("6",
                                       style: TextStyle(
                                       fontWeight: FontWeight.w900,
                                       fontSize: 19,


                                     ),),
                                        Text(" /8 glasses",style:
                                         TextStyle(
                                           fontWeight: FontWeight.w300,
                                           fontSize: 12,
                                           color: Colors.black54

                                         ),
                                        ),
                                     ]
                                   ),

                                   Container(
                                        width: 120,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.black12,
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 0.76, // value between 0.0 and 1.0
                                          child: Container(
                                            height: 6,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      )


                               ],

                             ),


                   ),Container(
                             width: 160,
                             height: 130,
                             margin: EdgeInsets.fromLTRB(10,10,40,0),
                             padding: EdgeInsets.fromLTRB(19,12,0,0),
                             decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             boxShadow: [
                             BoxShadow(
                                color: Colors.black.withOpacity(0.03), // Shadow color
                                spreadRadius: 1, // How much the shadow spreads
                                blurRadius: 8,  // How blurry the shadow is
                                offset: Offset(0, 0), // Position of the shadow (x, y)
                              ),
                            ],
                             color: Colors.white,
                              ),

                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                               children: [

                                 Container(

                                   width: 30,
                                   height: 30,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(7),
                                     color: Colors.deepPurpleAccent,
                                   ),
                                   child:
                                   Icon(
                                    Icons.water_drop,
                                    color: Colors.white,
                                    size: 18),
                                 ),
                                 SizedBox(height: 16,),
                                 Text("Sleep",
                                 style: TextStyle(
                                   fontWeight: FontWeight.w500,
                                   fontSize: 12,
                                   color: Colors.black54
                                 ),),
                                  SizedBox(height: 9),
                                   Row(
                                     children:[
                                       Text("7.5",
                                       style: TextStyle(
                                       fontWeight: FontWeight.w900,
                                       fontSize: 19,


                                     ),),
                                        Text(" hours",style:
                                         TextStyle(
                                           fontWeight: FontWeight.w300,
                                           fontSize: 12,
                                           color: Colors.black54

                                         ),
                                        ),
                                     ]
                                   ),

                                   Container(
                                        width: 120,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.black12,
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 0.76, // value between 0.0 and 1.0
                                          child: Container(
                                            height: 6,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.deepPurpleAccent,
                                            ),
                                          ),
                                        ),
                                      )


                               ],

                             ),


                   ),]

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
             mainAxisAlignment: MainAxisAlignment. start,
             children: [Container(
                       width: 160,
                       height: 80,
                       margin: EdgeInsets.fromLTRB(40,30,0,0),
                       padding: EdgeInsets.all(17),
                       decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       boxShadow: [
                       BoxShadow(
                          color: Colors.black.withOpacity(0.03), // Shadow color
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 8,  // How blurry the shadow is
                          offset: Offset(0, 0), // Position of the shadow (x, y)
                        ),
                      ],
                       color: Colors.deepOrange,
                      ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.add,
                            color: Colors.white,),

                            Text("Log Meal",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),),
                          ],

                        ),

             ),Container(
                       width: 160,
                       height: 80,
                       margin: EdgeInsets.fromLTRB(10,30,40,0),
                       padding: EdgeInsets.all(17),
                       decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       boxShadow: [
                       BoxShadow(
                          color: Colors.black.withOpacity(0.03), // Shadow color
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 8,  // How blurry the shadow is
                          offset: Offset(0, 0), // Position of the shadow (x, y)
                        ),
                      ],
                       color: Colors.green,
                       ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.monitor_heart,

                            color: Colors.white,),

                            Text("Start Workout",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),),
                          ],

                        ),



                      ),]

                   ),

      Row(
             mainAxisAlignment: MainAxisAlignment. start,
             children: [Container(
                       width: 160,
                       height: 80,
                       margin: EdgeInsets.fromLTRB(40,10,0,0),
                       padding: EdgeInsets.all(17),
                       decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       boxShadow: [
                       BoxShadow(
                          color: Colors.black.withOpacity(0.03), // Shadow color
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 8,  // How blurry the shadow is
                          offset: Offset(0, 0), // Position of the shadow (x, y)
                        ),
                      ],
                       color: Colors.blue,
                      ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.sports_score,
                            color: Colors.white,),

                            Text("Set Goals",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),),
                          ],

                        ),

             ),Container(
                       width: 160,
                       height: 80,
                       margin: EdgeInsets.fromLTRB(10,10,40,0),
                       padding: EdgeInsets.all(17),
                       decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       boxShadow: [
                       BoxShadow(
                          color: Colors.black.withOpacity(0.03), // Shadow color
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 8,  // How blurry the shadow is
                          offset: Offset(0, 0), // Position of the shadow (x, y)
                        ),
                      ],
                       color: Colors.purple,
                       ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,

                            color: Colors.white,),

                            Text("Start Workout",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),),
                          ],

                        ),



                      ),]

                   ),



    ]
  ),

  ),
);
}
}