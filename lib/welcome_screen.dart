import 'dart:developer' as dev;

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool updatePositionOnScroll(ScrollNotification scrollNotification) {
    // dev.log("scrollNotification.metrics.pixels  || ${scrollNotification.metrics.pixels}");
    // dev.log("MediaQuery.of(context).size.height  %% ${MediaQuery.of(context).size.height}");
    // dev.log("((MediaQuery.of(context).size.height - 25) / 2)  ## ${((MediaQuery.of(context).size.height - 26.5) / 2)}");
    setState(() {
      bg1OffSet = -scrollNotification.metrics.pixels;
      if ((scrollNotification.metrics.pixels) <=
          ((MediaQuery.of(context).size.height - 60) / 2)) {
        bg1TextOffSet = -scrollNotification.metrics.pixels;
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
        dev.log("bg1TextOpacity ===> $bg1TextOpacity");
      } else {
        bg1TextOpacity = 1;
      }
    });
    return true;
  }

  double bg1OffSet = 0;
  double bg1TextOffSet = 0;
  double bg1TextOpacity = 1;
  final ValueNotifier<Offset> bg1ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg2ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg3ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg4ImageOffset = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> bg5ImageOffset = ValueNotifier(Offset.zero);

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
          // bg1ImageOffset.value = event.position * 0.25;
          // bg2ImageOffset.value = event.position * 0.175;
          // bg3ImageOffset.value = event.position * 0.15;
          // bg4ImageOffset.value = event.position * 0.1;
          // bg5ImageOffset.value = event.position * 0.05;
          bg1ImageOffset.value = relativePosition * 0.275;
          bg2ImageOffset.value = relativePosition * 0.225;
          bg3ImageOffset.value = relativePosition * 0.175;
          bg4ImageOffset.value = relativePosition * 0.125;
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
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: const Color(0xFF121e58),
                  // color: const Color(0xFF152265),
                ),
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xFF121e58),
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
