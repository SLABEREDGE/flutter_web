import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:my_resume/utils/icons_path.dart';

import 'controller/general_config_controller.dart';
import 'utils/app_theme.dart';

class CustomSwiper extends StatefulWidget {
  final SwiperController controller;
  final double? cardWidth;
  final double? cardHeight;
  final Function(int)? selectedCardChange;

  const CustomSwiper(
      {super.key,
      this.cardWidth,
      this.cardHeight,
      this.selectedCardChange,
      required this.controller});

  @override
  State<CustomSwiper> createState() => _CustomSwiperState();
}

class _CustomSwiperState extends State<CustomSwiper> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      controller: widget.controller,
      autoplay: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        if (widget.selectedCardChange != null) {
          widget.selectedCardChange!(index);
        }
        return CustomCard(
          index: index,
        );
      },
      layout: SwiperLayout.CUSTOM,
      scrollDirection: Axis.vertical,
      loop: true,
      fade: 0,
      curve: Curves.decelerate,
      customLayoutOption: CustomLayoutOption(
        startIndex: 0,
        stateCount: 3,
      )
        ..addRotate([
          90 / 360,
          90 / 360,
          0.0,
        ])
        ..addTranslate(
          [
            Offset(-150.0, -generalConfigController.dheight.value),
            const Offset(0.0, 0),
            Offset(generalConfigController.dwidth.value * 0.5,
                generalConfigController.dheight.value * 0.7),
          ],
        ),
      // itemWidth: generalConfigController.dwidth.value,
      // itemHeight: generalConfigController.dheight.value,
      itemWidth: generalConfigController.dheight.value * 0.6,
      itemHeight: generalConfigController.dheight.value * 0.6,

      viewportFraction: 1, // Set this to a value less than 1.0
      // viewportFraction: 0.8, // Set this to a value less than 1.0
    );
  }
}

class CustomCard extends StatelessWidget {
  final int index;

  const CustomCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: generalConfigController.dheight.value * 0.6,
      // width: generalConfigController.dheight.value * 0.6,
      decoration: BoxDecoration(
        color: Styles.blackColor,
        // color: index == 1
        //     ? Colors.yellow
        //     : index == 2
        //         ? Colors.red
        //         : index == 3
        //             ? Colors.purple
        //             : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Styles.blackColor, width: 20),
        image: DecorationImage(
          image: index == 1
              ? AssetImage(appImages.dish1)
              : index == 2
                  ? AssetImage(appImages.dish2)
                  : index == 3
                      ? AssetImage(appImages.dish3)
                      : AssetImage(appImages.dish4),
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
