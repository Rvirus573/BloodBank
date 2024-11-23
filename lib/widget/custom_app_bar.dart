import 'package:flutter/material.dart';

Widget customAppBar(context, double hight, Color gColor1,
    imageicon, String text1, String text2) {
  return Container(
    height: hight,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        // image: DecorationImage(
        //     image: AssetImage('assets/icon/baiust.png',),
        //     fit: BoxFit.fill),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.elliptical(45, 30)),
        // gradient: LinearGradient(
        //     colors: [gColor1, gColor2],
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter)
        color: gColor1
            
            ),
    child: Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      imageicon,
                      height: 130,
                      width: 130,
                    ),

                    
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: Text(
                              text1,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Center(
                 child:  Text(text2,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: const Color.fromARGB(255, 0, 0, 0))),
                ),
                        ],
                      )
                       
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
