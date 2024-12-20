import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:my_resume/controller/general_config_controller.dart';
import 'package:my_resume/utils/icons_path.dart';

import 'card_swipe_animation.dart';
import 'utils/app_theme.dart';

class FoodKart extends StatefulWidget {
  const FoodKart({super.key});

  @override
  State<FoodKart> createState() => _FoodKartState();
}

class _FoodKartState extends State<FoodKart> {
  SwiperController swiperController = SwiperController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            right: -generalConfigController.dheight.value * 0.65,
            top: -generalConfigController.dheight.value * 0.3,
            child: Container(
              height: generalConfigController.dwidth.value * 0.6,
              width: generalConfigController.dwidth.value * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Styles.blackColor,
                  width: generalConfigController.dwidth.value * 0.06,
                ),
              ),
            ),
          ),
          // Positioned(
          //   right: generalConfigController.dheight.value * 0.1,
          //   top: generalConfigController.dheight.value * 0.2,
          //   child: Container(
          //     height: generalConfigController.dheight.value * 0.6,
          //     width: generalConfigController.dheight.value * 0.6,
          //     decoration: const BoxDecoration(
          //       color: Styles.blackColor,
          //       shape: BoxShape.circle,
          //     ),
          //     alignment: Alignment.center,
          //     child: Image.asset(
          //       appImages.dish3,
          //     ),
          //   ),
          // ),
          Positioned.fill(
            right: -generalConfigController.dheight.value,
            child: Container(
              // height: generalConfigController.dheight.value,
              // width: generalConfigController.dheight.value,
              // color: Styles.blueColor.withOpacity(0.1),
              child: CustomSwiper(
                controller: swiperController,
                selectedCardChange: (selectedIndex) {},
              ),
            ),
          ),

          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Foodkart",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Text("Menu",
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(width: 20),
                        Text(
                          "Food",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "Services",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "Blogs",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "Foodkart",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    const Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined),
                        SizedBox(width: 20),
                        Icon(Icons.menu_outlined),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              generalConfigController.dwidth.value * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Indian",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 46.0,
                                  color: Styles.lightOrangeColor,
                                ),
                          ),
                          Text(
                            "Restaurant",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 46.0,
                                  color: Styles.lightOrangeColor,
                                ),
                          ),
                          Text(
                            "Punjabi Thali",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 70.0,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Include rice, dal, vegetables, roti, papad, dahi\nchutney or pickel and a sweet dish.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  swiperController.move(0);
                                  log(" swiperController.index ${swiperController.index}");
                                },
                                child: Container(
                                  height: generalConfigController.dwidth.value *
                                      0.08,
                                  width: generalConfigController.dwidth.value *
                                      0.08,
                                  decoration: const BoxDecoration(
                                    color: Styles.blackColor,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    appImages.dish1,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  swiperController.move(1);
                                  log(" swiperController.index ${swiperController.index}");
                                },
                                child: Container(
                                  height: generalConfigController.dwidth.value *
                                      0.08,
                                  width: generalConfigController.dwidth.value *
                                      0.08,
                                  decoration: const BoxDecoration(
                                    color: Styles.blackColor,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    appImages.dish2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  swiperController.move(2);
                                  log(" swiperController.index ${swiperController.index}");
                                },
                                child: Container(
                                  height: generalConfigController.dwidth.value *
                                      0.08,
                                  width: generalConfigController.dwidth.value *
                                      0.08,
                                  decoration: const BoxDecoration(
                                    color: Styles.blackColor,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    appImages.dish3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  swiperController.move(3);
                                  log(" swiperController.index ${swiperController.index}");
                                },
                                child: Container(
                                  height: generalConfigController.dwidth.value *
                                      0.08,
                                  width: generalConfigController.dwidth.value *
                                      0.08,
                                  decoration: const BoxDecoration(
                                    color: Styles.blackColor,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    appImages.dish4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, top: 8, right: 10, bottom: 8),
                            decoration: BoxDecoration(
                              color: Styles.blackColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Explore",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Styles.whiteColor,
                                      ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Styles.whiteColor,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
