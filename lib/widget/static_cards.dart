import 'package:flutter/material.dart';

class StaticCards extends StatelessWidget {

  final bool showProgress;
  final IconData cardIcon;
  final Color cardIconColor;
  final String text;
  final String statusNumber;
  final String measureIcon;
  final Color progressBarColor;

  const StaticCards({super.key, required this.showProgress, required this.cardIcon, required this.cardIconColor, required this.text, required this.statusNumber, required this.measureIcon, required this.progressBarColor,  });

  @override
  Widget build(BuildContext context) {
    return  Container(
                               width: 160,
                               height: 130,
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
                                       color: cardIconColor,
                                     ),
                                     child:
                                     Icon(
                                      cardIcon,
                                      color: Colors.white,
                                      size: 18),
                                   ),
                                   SizedBox(height: 16,),
                                   Text(text,
                                   style: TextStyle(
                                     fontWeight: FontWeight.w500,
                                     fontSize: 12,
                                     color: Colors.black54
                                   ),),
                                    SizedBox(height: 9),
                                     Row(
                                       children:[
                                         Text(
                                           statusNumber,
                                         style: TextStyle(
                                         fontWeight: FontWeight.w900,
                                         fontSize: 19,


                                       ),),
                                          Text(
                                            measureIcon,style:
                                           TextStyle(
                                             fontWeight: FontWeight.w300,
                                             fontSize: 12,
                                             color: Colors.black54

                                           ),
                                          ),
                                       ]
                                     ),

                                    showProgress ? Container(
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
                                                color: progressBarColor,
                                              ),
                                            ),
                                          ),
                                        ):SizedBox.shrink()


                                 ],

                               ),


                     );
  }
}
