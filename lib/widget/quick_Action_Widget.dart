import 'package:flutter/material.dart';

class QuickActionWidget extends StatelessWidget {

  final String text;
  final Color color;
  final IconData icon;

  const QuickActionWidget({super.key, required this.text, required this.color, required this.icon, });

  @override
  Widget build(BuildContext context) {
    return Container(
                         width: 160,
                         height: 80,
                         padding: const EdgeInsets.all(17),
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
                         color: color,
                         ),
                          child: Column(
                            children: [
                              Icon(
                                icon,

                              color: Colors.white,),

                              Text(
                                text,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),),
                            ],

                          ),



                        );
  }
}
