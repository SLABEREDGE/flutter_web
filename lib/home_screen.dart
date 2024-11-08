import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_resume/controller/home_screen_controller.dart';
import 'package:my_resume/main.dart';
import 'package:my_resume/utils/icons_path.dart';
import 'package:o3d/o3d.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = getIt<HomeScreenController>();
  late Size size = const Size(0, 0);

  Future<void> initAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    homeScreenController.controller.animationName = animationName[6];
    homeScreenController.controller.cameraTarget(0, 0.035, -0.035);
    await Future.delayed(const Duration(milliseconds: 100));
    homeScreenController.controller.play(repetitions: 1);
    await smoothCameraTransition(
      interval: 40,
      duration: 2200,
      initialY: 0.035,
      currentY: 0.035,
      finalY: 0.025,
    );
    await smoothCameraOrbit(
      duration: 1000,
      startX: 0,
      endX: -90,
      endY: 90,
      endZ: 0,
    );
    // homeScreenController.controller.cameraTarget(0.015, 0.025, -0.020);
    // homeScreenController.controller.animationName = animationName[3];
    // await Future.delayed(const Duration(milliseconds: 100));
    // homeScreenController.controller.play();

    // homeScreenController.controller.pause();

    homeScreenController.controller.cameraTarget(0.018, 0.020, -0.030);
    homeScreenController.controller.animationName = animationName[7];
    await Future.delayed(const Duration(milliseconds: 100));
    homeScreenController.controller.play(repetitions: 1);
    await Future.delayed(const Duration(milliseconds: 2550));
    homeScreenController.controller.animationName = animationName[0];
    await Future.delayed(const Duration(milliseconds: 100));
    homeScreenController.controller.play();

    // await Future.delayed(const Duration(milliseconds: 1000));
    // homeScreenController.controller.cameraTarget(0, 0.035, 0.095);
  }

  Future<void> smoothCameraTransition({
    required double initialY,
    required double currentY,
    required double finalY,
    required double duration,
    required double interval,
  }) async {
    double stepY = (initialY - finalY) / (duration / interval);
    Completer<void> completer = Completer<void>();

    Timer.periodic(Duration(milliseconds: interval.toInt()), (timer) {
      if (currentY <= finalY) {
        currentY = finalY; // Ensure we reach exactly the target value
        homeScreenController.controller.cameraTarget(0, currentY, -0.035);
        timer.cancel();
        completer
            .complete(); // Complete the future to signal smooth transition is done
      } else {
        currentY -= stepY;
        homeScreenController.controller.cameraTarget(0, currentY, -0.035);
      }
      log("cameraTarget 0, $currentY, -0.035");
    });

    return completer.future; // Return the future to await on
  }

  Future<void> smoothCameraOrbit({
    required double startX,
    required double endX,
    required double endY,
    required double endZ,
    required int duration,
  }) async {
    double interval = 40; // Interval for the timer
    double stepX = (endX - startX) / (duration / interval);
    double currentX = startX;
    Completer<void> completer = Completer<void>();

    Timer.periodic(Duration(milliseconds: interval.toInt()), (timer) {
      if ((stepX < 0 && currentX <= endX) || (stepX > 0 && currentX >= endX)) {
        currentX = endX; // Ensure exact final position
        homeScreenController.controller.cameraOrbit(currentX, endY, endZ);
        timer.cancel();
        completer
            .complete(); // Complete the future to signal smooth orbit is done
      } else {
        currentX += stepX;
        homeScreenController.controller.cameraOrbit(currentX, endY, endZ);
      }
      log("cameraOrbit $currentX, $endY, $endZ");
    });
    return completer.future; // Return the future to await on
  }

//   bool updatePositionOnScroll(ScrollNotification scrollNotification) {
//     double scrollPosition = scrollNotification.metrics.pixels;
//     double maxScroll = scrollNotification.metrics.maxScrollExtent;

//     // Calculate the scroll percentage
//     double scrollPercentage = scrollPosition / maxScroll;

//     // Interpolate cameraTarget values
//     double targetX = lerp(0.0, 0.07, scrollPercentage); // Camera target X
//     double targetY = lerp(0.025, 0.035, scrollPercentage); // Camera target Y
//     double targetZ = lerp(-0.035, -0.020, scrollPercentage); // Camera target Z

//     // Interpolate cameraOrbit values
//     double orbitX = lerp(-90, -390, scrollPercentage); // Camera orbit X
//     double orbitY =
//         lerp(90, 90, scrollPercentage); // Camera orbit Y (Fixed to 90)
//     double orbitZ = lerp(0, 180, scrollPercentage); // Camera orbit Z

//     // Apply the interpolated values to cameraTarget and cameraOrbit
//     homeScreenController.controller.cameraTarget(targetX, targetY, targetZ);
//     homeScreenController.controller.cameraOrbit(orbitX, orbitY, orbitZ);

//     // Determine animation name based on scroll position
//     if (scrollPosition >= 1) {
//       homeScreenController.controller.animationName = animationName[5];
//     } else {
//       homeScreenController.controller.animationName = animationName[0];
//       homeScreenController.controller.cameraTarget(0, 0.025, -0.035);
//       homeScreenController.controller.cameraOrbit(-90, 90, 0);
//     }

//     // Play animation after a small delay
//     Future.delayed(const Duration(milliseconds: 100)).then((value) {
//       homeScreenController.controller.play();
//     });

//     return true;
//   }

// // Linear interpolation function
//   double lerp(double start, double end, double t) {
//     return start + (end - start) * t;
//   }

  bool updatePositionOnScroll(ScrollNotification scrollNotification) {
    double scrollPosition = scrollNotification.metrics.pixels;
    double maxScroll = scrollNotification.metrics.maxScrollExtent;

    // Calculate the scroll percentage
    double scrollPercentage = scrollPosition / maxScroll;

    // If scrollPosition is less than 1, reset to original values
    if (scrollPosition < 1) {
      homeScreenController.controller.cameraTarget(0, 0.025, -0.035);
      homeScreenController.controller.cameraOrbit(-90, 90, 0);
      homeScreenController.controller.animationName = animationName[0];

      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        homeScreenController.controller.play();
      });
    } else {
      // Interpolate cameraTarget values
      double targetX = lerp(0.0, 0.07, scrollPercentage); // Camera target X
      double targetY = lerp(0.025, 0.035, scrollPercentage); // Camera target Y
      double targetZ =
          lerp(-0.035, -0.020, scrollPercentage); // Camera target Z

      // Interpolate cameraOrbit values
      double orbitX = lerp(-90, -390, scrollPercentage); // Camera orbit X
      double orbitY =
          lerp(90, 90, scrollPercentage); // Camera orbit Y (Fixed to 90)
      double orbitZ = lerp(0, 180, scrollPercentage); // Camera orbit Z

      // Apply the interpolated values to cameraTarget and cameraOrbit
      homeScreenController.controller.cameraTarget(targetX, targetY, targetZ);
      homeScreenController.controller.cameraOrbit(orbitX, orbitY, orbitZ);

      // Determine animation name based on scroll position
      homeScreenController.controller.animationName = animationName[5];

      // Play animation after a small delay
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        homeScreenController.controller.play();
      });
    }

    return true;
  }

// Linear interpolation function
  double lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  @override
  void initState() {
    homeScreenController.controller = O3DController();
    homeScreenController.controller.logger = (data) {
      log("controller.logger ==> $data");
    };
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await initAnimation();
      },
    );
    super.initState();
  }

  List<String> animationName = [
    "Idle",
    "Die",
    "Hurt",
    "Run",
    "Start Flying",
    "Hover",
    "Fire While Flying",
    "Attack"
  ];

  ValueNotifier<String> animationNameString =
      // ValueNotifier("Fire While Flying");
      ValueNotifier("Idle");

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          return updatePositionOnScroll(notification);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF000000),
                    Color.fromARGB(255, 25, 22, 28),
                    Color.fromARGB(255, 33, 25, 40),
                    Color.fromARGB(255, 44, 30, 57),
                    Color.fromARGB(255, 44, 30, 57),
                    Color.fromARGB(255, 33, 25, 40),
                    Color.fromARGB(255, 25, 22, 28),
                    Color(0xFF000000),

                    // Color(0xFF36224a), // Dark purple
                    // Color(0xFF673796), // Medium purple
                    // Color(0xFFe8afe5), // Light pink
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: -size.height * 0.2,
              child: Transform.flip(
                flipX: true,
                child: Image.asset(
                  appImages.cliff,
                  height: size.height * 0.65,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.08,
              child: Text(
                "WYVERN",
                style: TextStyle(
                  fontSize: size.height * 0.15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(10.0, 10.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(10.0, 10.0),
                      blurRadius: 8.0,
                      color: Color.fromARGB(255, 25, 22, 28),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.08,
              child: Text(
                "SHIRYU 紫龍",
                style: TextStyle(
                  fontSize: size.height * 0.300,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(10.0, 10.0),
                      blurRadius: 1.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(10.0, 10.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(255, 25, 22, 28),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: ValueListenableBuilder(
                  valueListenable: animationNameString,
                  builder: (context, v, c) {
                    return O3D(
                      ar: false,
                      autoPlay: false,
                      autoRotate: false,
                      fieldOfView: "40deg",
                      loading: Loading.lazy,
                      cameraTarget: CameraTarget(0, 0.035, -0.035),

                      interactionPrompt:
                          InteractionPrompt.none, // disableZoom: true,
                      cameraControls: false,
                      controller: homeScreenController.controller,
                      animationName: animationNameString.value,
                      src: 'assets/shadow_dragon.glb',
                    );
                  }),
            ),
            Visibility(
              visible: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: animationName.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            // homeScreenController.controller.pause();

                            // controller.availableAnimations().then((animations) =>
                            //     log("Available animations: $animations"));
                            animationNameString.value = animationName[index];
                            homeScreenController.controller.animationName =
                                animationNameString.value;
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            homeScreenController.controller
                                .cameraTarget(0.015, 0.025, -0.020);
                            log("Current animation name: ${animationNameString.value}");
                            // homeScreenController.controller.play(repetitions: 1);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: size.height * 0.05,
                            width: size.width * 0.08,
                            child: Center(
                              child: Text(
                                animationName[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          homeScreenController.controller.play(repetitions: 1);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: size.height * 0.05,
                          width: size.width * 0.08,
                          child: const Center(
                            child: Text(
                              "PLAY",
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          homeScreenController.controller.pause();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: size.height * 0.05,
                          width: size.width * 0.08,
                          child: const Center(
                            child: Text(
                              "PAUSE",
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // homeScreenController.controller.pause();
                          // homeScreenController.controller.resetAnimation();
                          // homeScreenController.controller.resetCameraOrbit();
                          // homeScreenController.controller.resetCameraTarget();
                          // await Future.delayed(const Duration(seconds: 5));
                          // await initAnimation();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: size.height * 0.05,
                          width: size.width * 0.08,
                          child: const Center(
                            child: Text(
                              "initi",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
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
                    // color: Colors.yellow.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraPosition {
  final double x;
  final double y;
  final double z;

  CameraPosition(this.x, this.y, this.z);
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
