import 'package:get/get.dart';
import 'package:o3d/o3d.dart';

class HomeScreenController extends GetxController {
  O3DController controller = O3DController();
  RxBool isAnimationPlaying = false.obs;
}
