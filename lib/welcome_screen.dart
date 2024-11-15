import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double bg1OffSet = 0;
  double bg1TextOffSet = 0;
  double bg1TextOpacity = 1;
  final ValueNotifier<Offset> bg1ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg2ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg3ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg4ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg5ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<bool> chiragPanchal = ValueNotifier(false);
  final ValueNotifier<double> t1 = ValueNotifier(100);
  final ValueNotifier<double> t2 = ValueNotifier(300);
  final ValueNotifier<double> t3 = ValueNotifier(400);

  bool updatePositionOnScroll(ScrollNotification scrollNotification) {
    dev.log(
        "scrollNotification.metrics.pixels ===> ${scrollNotification.metrics.pixels}");
    setState(() {
      bg1OffSet = -scrollNotification.metrics.pixels;
      if ((scrollNotification.metrics.pixels) <=
          ((MediaQuery.of(context).size.height - 60) / 2)) {
        bg1TextOffSet = -scrollNotification.metrics.pixels;
        // dev.log("bg1TextOffSet ===> $bg1TextOffSet");
      }
      if (MediaQuery.of(context).size.height -
              scrollNotification.metrics.pixels <
          60) {
        bg1TextOpacity = (MediaQuery.of(context).size.height -
                scrollNotification.metrics.pixels) /
            120;
        if (bg1TextOpacity < 0) {
          bg1TextOpacity = 0;
        }
        // dev.log("bg1TextOpacity ===> $bg1TextOpacity");
      } else {
        bg1TextOpacity = 1;
      }
      // if (scrollNotification.metrics.pixels > 100) {
      //   chiragPanchal.value = true;
      //   dev.log("chiragPanchal.value ==> ${chiragPanchal.value}");
      //   dev.log(
      //       "(-scrollNotification.metrics.pixels) > 300 ==> ${(scrollNotification.metrics.pixels) > 300}");
      // } else {
      //   chiragPanchal.value = false;
      // }
      if ((scrollNotification.metrics.pixels <=
              MediaQuery.of(context).size.height) &&
          t1.value >= 0) {
        t1.value = 100 - scrollNotification.metrics.pixels;
      } else if (scrollNotification.metrics.pixels == 0) {
        t1.value = 200;
      }
      if ((scrollNotification.metrics.pixels <=
              MediaQuery.of(context).size.height) &&
          t2.value >= 120) {
        t2.value = 300 - scrollNotification.metrics.pixels;
      } else if (scrollNotification.metrics.pixels == 0) {
        t2.value = 300;
      }
      if ((scrollNotification.metrics.pixels <=
              MediaQuery.of(context).size.height) &&
          t3.value >= 300) {
        t3.value = 400 - scrollNotification.metrics.pixels;
      } else if (scrollNotification.metrics.pixels == 0) {
        t3.value = 400;
      }
      if (scrollNotification.metrics.pixels >=
          (MediaQuery.of(context).size.height / 2)) {
        if (t2.value >= 80) {
          t2.value = --t2.value;
        }
        if (t3.value >= 250) {
          t3.value = --t3.value;
        }
      }
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);
    return Scaffold(
      backgroundColor: const Color(0xFF121e58),
      body: MouseRegion(
        onHover: (event) {
          // dev.log("callled ======> ${event.position}");
          final relativePosition = event.position - screenCenter;
          // bg1ImageOffset.value = relativePosition * 0.275;
          // bg2ImageOffset.value = relativePosition * 0.225;
          // bg3ImageOffset.value = relativePosition * 0.175;
          // bg4ImageOffset.value = relativePosition * 0.125;
          // bg5ImageOffset.value = relativePosition * 0.075;
          bg1ImageOffset.value = relativePosition * 0.375;
          bg2ImageOffset.value = relativePosition * 0.325;
          bg3ImageOffset.value = relativePosition * 0.275;
          bg4ImageOffset.value = relativePosition * 0.225;
          bg5ImageOffset.value = relativePosition * 0.075;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: NotificationListener<ScrollNotification>(
            onNotification: updatePositionOnScroll,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Visibility(
                        // visible: false,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                "assets/bg0.png",
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: bg1ImageOffset,
                              builder: (context, v, c) {
                                return AnimatedPositioned(
                                  left: bg1ImageOffset.value.dx,
                                  top: bg1ImageOffset.value.dy,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/bg1.png",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: bg2ImageOffset,
                              builder: (context, v, c) {
                                return AnimatedPositioned(
                                  left: bg2ImageOffset.value.dx,
                                  top: bg2ImageOffset.value.dy,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/bg2.png",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: bg3ImageOffset,
                              builder: (context, v, c) {
                                return AnimatedPositioned(
                                  left: bg3ImageOffset.value.dx,
                                  top: bg3ImageOffset.value.dy,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/bg3.png",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: bg1TextOffSet,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Opacity(
                                    opacity: bg1TextOpacity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "WELCOME",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: 60,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          // "Writing Testcases for your code is doubting\nyour own coding abilities. It's sign of weakness",
                                          '"Trust your code like a craftsman trusts his tools\nsecond-guessing it only dulls your edge"',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: bg4ImageOffset,
                              builder: (context, v, c) {
                                return AnimatedPositioned(
                                  left: bg4ImageOffset.value.dx,
                                  top: bg4ImageOffset.value.dy,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/bg4.png",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: bg5ImageOffset,
                              builder: (context, v, c) {
                                return AnimatedPositioned(
                                  left: bg5ImageOffset.value.dx,
                                  top: bg5ImageOffset.value.dy,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/bg5.png",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                "assets/bg6.png",
                                // fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.05),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF121e58),
                              Color(0xFF000000),
                            ],
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width * 0.98,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // color: Colors.blue[900]
                            // gradient: const LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [
                            //     Color(0xFF121e58),
                            //     Color(0xFF000000),
                            //   ],
                            // ),
                          ),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: t1,
                                builder: (context, v, c) {
                                  return Positioned(
                                    top: t1.value,
                                    child: const Text(
                                      "CHIRAG PANCHAL",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 80,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                  // .animate(
                                  //     target: chiragPanchal.value ? 1 : 0)
                                  // .slideY(
                                  //   begin: 0.2,
                                  //   end: 0,
                                  //   duration: 300.ms,
                                  //   curve: Curves.easeIn,
                                  // );
                                },
                              ),
                              ValueListenableBuilder(
                                  valueListenable: t2,
                                  builder: (context, v, c) {
                                    return Positioned(
                                      top: t2.value,
                                      child: const Text(
                                        "WEB DESINGER",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 180,
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                    // .animate(
                                    //     target: chiragPanchal.value ? 1 : 0)
                                    // .slideY(
                                    //   begin: 0.25,
                                    //   end: 0,
                                    //   duration: 300.ms,
                                    //   curve: Curves.easeIn,
                                    // );
                                  }),
                              ValueListenableBuilder(
                                valueListenable: t3,
                                builder: (context, v, c) {
                                  return Positioned(
                                    top: t3.value,
                                    child: const Text(
                                      "FREELANCE",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 130,
                                        height: 1,
                                        wordSpacing: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                  // .animate(
                                  //     target: chiragPanchal.value ? 1 : 0)
                                  // .slideY(
                                  //   begin: 0.35,
                                  //   end: 0,
                                  //   duration: 500.ms,
                                  //   curve: Curves.easeIn,
                                  // );
                                },
                              ),

                              // Row(
                              //   children: [
                              //     Container(
                              //       width: MediaQuery.of(context).size.width *
                              //           0.3,
                              //       height:
                              //           MediaQuery.of(context).size.height *
                              //               0.4,
                              //       decoration: BoxDecoration(
                              //         color: const Color(0xff111940),
                              //         borderRadius: BorderRadius.circular(20),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        // color: const Color(0xFF121e58),
                        // color: const Color.fromARGB(255, 76, 86, 134),
                        // color: Colors.black,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF000000),
                              Color(0xFF111940),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
